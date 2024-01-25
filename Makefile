all:
	if [ -d "/home/akhellad/data" ]; then \
		echo "/home/akhellad/data already exists"; else \
		sudo mkdir /home/akhellad/data; \
		echo "data directory created successfully"; \
	fi

	if [ -d "/home/akhellad/data/wordpress" ]; then \
		echo "/home/akhellad/data/wordpress already exists"; else \
		sudo mkdir /home/akhellad/data/wordpress; \
		echo "wordpress directory created successfully"; \
	fi

	if [ -d "/home/akhellad/data/mariadb" ]; then \
		echo "/home/akhellad/data/mariadb already exists"; else \
		sudo mkdir /home/akhellad/data/mariadb; \
		echo "mariadb directory created successfully"; \
	fi
	sudo docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	sudo docker compose -f ./srcs/docker-compose.yml down -v

reset:
	if [ -d "/home/akhellad/data/wordpress" ]; then \
	sudo rm -rf /home/akhellad/data/wordpress && \
	echo "successfully removed all contents from /home/akhellad/data/wordpress/"; \
	fi;

	if [ -d "/home/akhellad/data/mariadb" ]; then \
	sudo rm -rf /home/akhellad//data/mariadb && \
	echo "successfully removed all contents from /home/akhellad/data/mariadb/"; \
	fi;
	
fclean:
	sudo docker compose -f ./srcs/docker-compose.yml down --rmi all -v
	sudo docker system prune -a --force
	if [ -d "/home/akhellad/data/wordpress" ]; then \
	sudo rm -rf /home/akhellad/data/wordpress && \
	echo "successfully removed all contents from /home/akhellad/data/wordpress/"; \
	fi;

	if [ -d "/home/akhellad/data/mariadb" ]; then \
	sudo rm -rf /home/akhellad//data/mariadb && \
	echo "successfully removed all contents from /home/akhellad/data/mariadb/"; \
	fi;

re: fclean all

ls:
	sudo docker image ls
	sudo docker ps

.PHONY: all, clean, fclean, re, ls