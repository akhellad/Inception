FROM debian:bullseye

RUN apt update -y

RUN apt upgrade -y

RUN apt-get install mariadb-server mariadb-client procps -y

RUN mkdir -p /var/run/mysqld && \
chown -R mysql:mysql /var/run/mysqld && \
chmod 777 /var/run/mysqld

RUN mkdir -p /var/lib/mysql && \
    chown -R mysql /var/lib/mysql && \
chmod 777 /var/lib/mysql

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cn

COPY tools/config.sh /usr/bin/config.sh

RUN chmod +x /usr/bin/config.sh

EXPOSE 3306

RUN service mariadb start

CMD ["./usr/bin/config.sh"]