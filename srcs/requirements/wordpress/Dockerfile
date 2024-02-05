# Utilise Alpine Linux 3.18 comme image de base
FROM alpine:3.18

# Définit la version de PHP à utiliser
ENV PHP_VERSION 81

# Met à jour les paquets et installe les dépendances nécessaires, y compris PHP et ses extensions, ainsi que curl et mariadb-client
RUN apk update && \
    apk add --no-cache curl mariadb-client wget \
    php${PHP_VERSION} \
    php${PHP_VERSION}-common \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-pdo \
    php${PHP_VERSION}-opcache \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-phar \
    php${PHP_VERSION}-iconv \
    php${PHP_VERSION}-cli \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-tokenizer \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-xmlwriter \
    php${PHP_VERSION}-simplexml \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-mysqli

# Définit le répertoire de travail pour les commandes suivantes
WORKDIR /var/www/html

# Télécharge WP CLI pour faciliter la gestion de WordPress via la ligne de commande
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Télécharge WordPress en utilisant WP CLI
RUN wp core download --allow-root --path=/var/www/html

# Copie le script de démarrage dans le conteneur et le rend exécutable
COPY tools/wordpress_start.sh /wordpress_start.sh
RUN chmod +x /wordpress_start.sh

# Expose le port 9000 pour le service PHP-FPM
EXPOSE 9000

# Utilise le script de démarrage comme point d'entrée pour démarrer le conteneur
ENTRYPOINT ["/wordpress_start.sh"]
