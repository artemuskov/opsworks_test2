#! /bin/bash

eval $(docker-machine env aws-nginx)
docker run -d -p 8000:80 artemuskov/nginx-lua:latest
docker ps
eval "$(docker-machine env -u)"


