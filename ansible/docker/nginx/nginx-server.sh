#!/bin/bash

case $1 in

build)
       docker build -t nginx-alpine .
       exit 0
       ;;
create)
       docker run -d \
              --name nginx-server \
              -p 80:80 \
              --restart unless-stopped \
              nginx-alpine
       exit 0
       ;;
start)
       docker start nginx-server
       exit 0
       ;;
stop)
       docker stop nginx-server
       exit 0
       ;;
destroy)
       docker rm nginx-server
       docker rmi nginx-alpine
       exit 0
       ;;
esac
exit 0
