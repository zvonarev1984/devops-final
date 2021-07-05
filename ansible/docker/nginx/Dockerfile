FROM alpine:3.13

RUN apk add --update nginx && rm -rf /var/cache/apk/*

COPY nginx-conf/nginx.conf /etc/nginx/nginx.conf

COPY nginx-conf/default.conf /etc/nginx/conf.d/default.conf

RUN mkdir /usr/share/nginx/html

COPY site/index.html /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]


