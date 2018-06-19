FROM alpine:3.7


RUN apk add --no-cache openssl curl zlib libxslt libxml2 gd perl git make g++

# modules
RUN mkdir /usr/local/src
RUN cd /usr/local/src && git clone http://luajit.org/git/luajit-2.0.git && cd luajit-2.0 && make && make install && make clean
RUN cd /usr/local/src && git clone https://github.com/simpl/ngx_devel_kit.git 
RUN cd /usr/local/src && git clone https://github.com/openresty/lua-nginx-module.git
RUN cd /usr/local/src && wget https://github.com/libgd/libgd/releases/download/gd-2.2.5/libgd-2.2.5.tar.gz && tar -xvzf libgd-2.2.5.tar.gz && cd libgd-2.2.5 && ./configure && make && make install && make clean
RUN cd /usr/local/src && wget https://github.com/maxmind/geoip-api-c/releases/download/v1.6.12/GeoIP-1.6.12.tar.gz && tar -xzvf GeoIP-1.6.12.tar.gz && cd GeoIP-1.6.12 && ./configure && make && make install && make clean
RUN cd /usr/local/src && wget https://ftp.pcre.org/pub/pcre/pcre-8.42.tar.gz && tar -xvzf pcre-8.42.tar.gz && cd pcre-8.42 && ./configure && make && make install && make clean
RUN cd /usr/local/src && wget http://zlib.net/zlib-1.2.11.tar.gz && tar -xvzf zlib-1.2.11.tar.gz && cd zlib-1.2.11 && ./configure && make && make install && make clean


# tell nginx's build system where to find LuaJIT 2.0:
ENV LUAJIT_LIB /usr/local/lib/
ENV LUAJIT_INC /usr/local/include/luajit-2.0

# create group and user for nginx
RUN addgroup nginx && adduser -H nginx -G nginx -D

# nginx 
RUN cd /usr/local/src && wget https://nginx.org/download/nginx-1.13.6.tar.gz
RUN cd /usr/local/src && tar -vzxf nginx-1.13.6.tar.gz
RUN cd /usr/local/src/nginx-1.13.6 && ./configure \
	--add-module=/usr/local/src/ngx_devel_kit \
	--add-module=/usr/local/src/lua-nginx-module \
	--sbin-path=/usr/sbin/nginx \
&& make && make install && make clean

# Add additional binaries into PATH for convenience
ENV PATH=$PATH:/usr/local/bin/:/usr/local/sbin/:/usr/bin/:/usr/sbin/:/usr/sbin/nginx

#Clean
RUN rm -rf /usr/local/src/*

WORKDIR /usr/share/nginx

# Copy nginx configuration files
COPY nginx/nginx.conf /etc/nginx/nginx.conf
COPY nginx/default.conf /etc/nginx/conf.d/default.conf

#Copy custom index.html
RUN mkdir /usr/share/nginx/opsworks
ADD ./index.html /usr/local/nginx/html/index.html
RUN chown -R nginx:nginx /usr/share/nginx

# This is the default CMD
CMD ["nginx", "-g", "daemon off;"]
