
FROM alpine:3.21.4

#good location?
WORKDIR /usr/local/bin/mariadb

COPY ["setup.sh", "."]
RUN chmod +x setup.sh

COPY ["conf/mariadb.cnf", "/etc/my.cnf.d/"]
RUN chmod +r /etc/my.cnf.d/mariadb.cnf

RUN apk update && apk add mariadb mariadb-client

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ENTRYPOINT ["sh", "setup.sh"]