#!/bin/sh

cd /var/www/html

set -x

wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /usr/local/bin/wp || { echo "Failed to download wp-cli.phar"; exit 1; }

chmod +x /usr/local/bin/wp

if [ ! -f /var/www/html/wp-config.php ]; then
    wp core download --allow-root

	db_user_pw=$(cat $MYSQL_USER_PASSWORD_FILE)

    wp config create \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$DATABASE_USER \
        --dbpass=$db_user_pw \
        --dbhost=mariadb \
        --force
	
	wp_admin_pw=$(cat $WORDPRESS_ADMIN_PASSWORD_FILE)

    wp core install --url="$DOMAIN_NAME" --title="$WORDPRESS_TITLE" \
        --admin_user="$WORDPRESS_ADMIN" \
        --admin_password="$wp_admin_pw" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
		--url=$DOMAIN \
        --allow-root \
        --skip-email \
        --path=/var/www/html

	wp_user_pw=$(cat $WORDPRESS_USER_PASSWORD_FILE)

    wp user create \
        --allow-root \
        $WORDPRESS_USER $WORDPRESS_USER_EMAIL \
        --user_pass=$wp_user_pw
fi

chown -R $WEB_USER:$WEB_GROUP /var/www/html

chmod -R 755 /var/www/html/

php-fpm83 -F