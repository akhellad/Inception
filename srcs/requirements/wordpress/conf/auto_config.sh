#!/bin/bash

# Assure-toi que le répertoire de travail existe
mkdir -p /var/www/html
cd /var/www/html

# Télécharger WordPress
wp core download --allow-root

# Configurer WordPress avec WP-CLI
wp core config \
    --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER \
    --dbpass=$MYSQL_PASSWORD \
    --dbhost=$MYSQL_HOST \
    --dbprefix=wp_ \
    --extra-php <<PHP
define( 'WP_DEBUG', true );
define( 'WP_DEBUG_LOG', true );
PHP

# Installer WordPress
wp core install \
    --url=https://yourdomain.com \
    --title="Your WordPress Site" \
    --admin_user=admin \
    --admin_password=adminpassword \
    --admin_email=admin@example.com \
    --allow-root

# Démarrer le serveur web (Nginx, Apache, etc.)
exec "$@"
