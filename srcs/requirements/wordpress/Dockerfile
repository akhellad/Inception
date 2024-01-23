FROM debian:bullseye

RUN apt update

RUN apt-get install wget -y

RUN apt-get install -y php7.3\
 php-fpm\
 php-mysql\
 mariadb-client

RUN wget https://fr.wordpress.org/wordpress-6.4.2-fr_FR.tar.gz -P /var/www

RUN cd /var/www && tar -xzf wordpress-6.4.2-fr_FR.tar.gz && rm wordpress-6.4.2-fr_FR.tar.gz

RUN		chown -R root:root /var/www/wordpress

COPY conf/www.conf /usr/local/etc/php-fpm.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar

RUN mv wp-cli.phar /usr/local/bin/wp

COPY conf/auto_config.sh /usr/local/bin/auto_config.sh

RUN chmod +x /usr/local/bin/auto_config.sh
