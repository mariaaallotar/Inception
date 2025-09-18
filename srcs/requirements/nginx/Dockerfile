FROM alpine:3.21

RUN apk update && apk add \
	nginx \
	openssl

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 \
	-newkey rsa:4096 \
	-keyout /etc/nginx/ssl/certificate.key \
	-out /etc/nginx/ssl/certificate.crt \
	-sha256 \
	-days 3650 \
	-nodes \
	-subj "/C=FI/ST=Uusimaa/L=Helsinki/O=MyCompany/OU=MyDepartment/CN=$DOMAIN"

ARG WEB_USER
ARG WEB_GROUP
#RUN addgroup -S $WEB_GROUP
RUN adduser -D -H -s /sbin/nologin -G $WEB_GROUP $WEB_USER
RUN mkdir -p /var/www/html
RUN chown -R $WEB_USER:$WEB_GROUP /var/www/html
CMD ["nginx", "-g", "daemon off;"]

EXPOSE 443