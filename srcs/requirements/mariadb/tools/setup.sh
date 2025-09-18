#!/bin/sh

root_pw=$(cat $MYSQL_ROOT_PASSWORD_FILE)
user_pw=$(cat $MYSQL_USER_PASSWORD_FILE)

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --basedir=/usr --user=mysql --datadir=/var/lib/mysql
    mysqld --user=mysql --bootstrap << EOF

USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY "${root_pw}";
CREATE USER $DATABASE_USER@'%' IDENTIFIED BY "${user_pw}";

CREATE DATABASE $MYSQL_DATABASE;
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$DATABASE_USER'@'%';
FLUSH PRIVILEGES;
EOF

fi

exec mysqld --defaults-file=/etc/my.cnf.d/mariadb.cnf