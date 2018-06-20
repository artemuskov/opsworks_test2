#! /bin/bash

eval $(docker-machine env aws-nginx)
docker pull artemuskov/nginx-lua
docker container stop nginx-lua
docker container rm nginx-lua
docker run -d -p 8000:80 --name nginx-lua artemuskov/nginx-lua
eval "$(docker-machine env -u)"

