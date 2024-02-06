all: setup_dirs launch_containers

setup_dirs:
	@{ \
	if [ -d "/home/akhellad/data" ]; then \
		echo "Checking: /home/akhellad/data exists."; \
	else \
		sudo mkdir /home/akhellad/data; \
		echo "Action: Created /home/akhellad/data directory."; \
	fi; \
	if [ -d "/home/akhellad/data/wordpress" ]; then \
		echo "Checking: /home/akhellad/data/wordpress exists."; \
	else \
		sudo mkdir /home/akhellad/data/wordpress; \
		echo "Action: Created /home/akhellad/data/wordpress directory."; \
	fi; \
	if [ -d "/home/akhellad/data/mariadb" ]; then \
		echo "Checking: /home/akhellad/data/mariadb exists."; \
	else \
		sudo mkdir /home/akhellad/data/mariadb; \
		echo "Action: Created /home/akhellad/data/mariadb directory."; \
	fi; \
	}

launch_containers:
	@echo "Launching Docker containers..."
	@sudo docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@echo "Taking down Docker containers..."
	@sudo docker compose -f ./srcs/docker-compose.yml down -v

reset: clean_directories

clean_directories:
	@if [ -d "/home/akhellad/data/wordpress" ]; then \
		sudo rm -rf /home/akhellad/data/wordpress && \
		echo "Cleaning: Removed /home/akhellad/data/wordpress/"; \
	fi; \
	if [ -d "/home/akhellad/data/mariadb" ]; then \
		sudo rm -rf /home/akhellad/data/mariadb && \
		echo "Cleaning: Removed /home/akhellad/data/mariadb/"; \
	fi;

fclean: clean_directories prune_docker

prune_docker:
	@echo "Fully cleaning Docker environment..."
	@sudo docker compose -f ./srcs/docker-compose.yml down --rmi all -v
	@sudo docker system prune -a --force

re: fclean all

ls:
	@echo "Listing Docker images and containers..."
	@sudo docker image ls
	@sudo docker ps

.PHONY: all setup_dirs launch_containers down reset clean_directories fclean prune_docker re ls
