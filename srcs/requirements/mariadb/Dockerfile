# Utilise Alpine Linux 3.18 comme image de base
FROM alpine:3.18

# Met à jour le système et installe MariaDB et son client sans garder de cache
RUN apk update && \
    apk upgrade && \
    apk add --no-cache mariadb mariadb-client

# Crée les répertoires nécessaires pour le fonctionnement de MariaDB
RUN mkdir -p /run/mysqld /var/lib/mysql

# Modifie la configuration de MariaDB pour activer les connexions réseau
RUN sed -i "s|skip-networking|#skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf

# Initialise la base de données sans créer la base de test
RUN mariadb-install-db --user=mysql --datadir=/var/lib/mysql --skip-test-db

# Copie le script de configuration dans le conteneur et le rend exécutable
COPY ./conf/config.sh /config.sh
RUN chmod +x /config.sh

# Expose le port 3306 pour permettre la connexion à MariaDB
EXPOSE 3306

# Définit le script de configuration comme point d'entrée pour initialiser le conteneur
ENTRYPOINT ["/config.sh"]
