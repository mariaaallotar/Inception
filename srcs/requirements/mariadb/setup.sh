#!/bin/bash

set -ex

root_pw=$(cat $MYSQL_ROOT_PASSWORD_FILE)

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --basedir=/usr --user=mysql --datadir=/var/lib/mysql
    mysqld --user=mysql --bootstrap << EOF

USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY "${root_pw}";
FLUSH PRIVILEGES;
EOF

fi

exec mysqld --defaults-file=/etc/my.cnf.d/mariadb.cnf