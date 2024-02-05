#!/bin/sh

# Modifie la propriété des répertoires pour l'utilisateur mysql
chown -R mysql:mysql /var/lib/mysql /run/mysqld

# Attend un peu pour s'assurer que tout est prêt
sleep 10

# Vérifie si la base de données spécifiée n'existe pas déjà
if [ ! -d "/var/lib/mysql/${DB_NAME}" ]; then

    # Crée un fichier SQL temporaire pour configurer la base de données
    cat << EOF > /tmp/db.sql
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASS}';
CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_PASS}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    # Initialise la base de données avec les configurations spécifiées
    mariadbd --user=mysql --bootstrap < /tmp/db.sql
    
    # Supprime le fichier SQL temporaire
    rm -f /tmp/db.sql
else
    # Message indiquant que la base de données existe déjà
    echo "Database already exists"
fi

# Exécute le serveur de base de données MariaDB
exec mariadbd --user=mysql --bind-address=0.0.0.0
