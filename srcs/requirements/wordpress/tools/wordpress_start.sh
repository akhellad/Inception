#!/bin/sh
# set listening port for php fpm
until mysql -h $DB_HOST -u $DB_USER -p$DB_PASS -e '' 2>/dev/null;do
	echo "waiting for mariadb to start..."
	sleep 1
done
sed -i "s/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/g" /etc/php81/php-fpm.d/www.conf

# start services
wp config create --allow-root \
	--dbname=${DB_NAME} \
	--dbuser=${DB_USER} \
	--dbpass=${DB_PASS} \
	--dbhost=${DB_HOST} \
	--force
wp core install --allow-root \
	--title=PAINCEPTION \
	--url=${DOMAIN_NAME} \
	--admin_user=${WP_ADMIN_USER} \
	--admin_password=${WP_ADMIN_PASS} \
	--admin_email=${WP_ADMIN_EMAIL}
wp user create ${WP_USER_NAME} ${WP_USER_EMAIL} \
	--user_pass=${WP_USER_PASS} --role=${WP_USER_ROLE}
wp option update home ${DOMAIN_NAME} --allow-root
wp option update siteurl ${DOMAIN_NAME} --allow-root

php-fpm${PHP_VERSION} -F