#!/bin/bash

set -e

service mariadb start

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]; then
    echo "Database already exists"
else
    echo "Performing secure installation"  
    # Créer la base de données et l'utilisateur
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
  #  echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;" | mysql -u root -p"$MYSQL_ROOT_PASSWORD"
    echo "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" | mysql -u root -p"$MYSQL_ROOT_PASSWORD"
    echo "FLUSH PRIVILEGES;" | mysql -u root -p"$MYSQL_ROOT_PASSWORD"

    # Importer la base de données depuis le fichier SQL
    mysql -u root -p"$MYSQL_ROOT_PASSWORD" "$MYSQL_DATABASE" < /opt/wordpress.sql
fi

service mariadb stop

#exec "$@"

