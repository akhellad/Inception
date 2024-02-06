# Inception Project

## Introduction

This repository contains the Inception project, a comprehensive assignment from the 42 school curriculum that focuses on deepening understanding of containerization and orchestration with Docker. The project involves setting up a small infrastructure composed of several services in Docker containers, including a web server with PHP, a database, and an admin tool, all managed through Docker-compose. The goal is to practice creating a secure and efficient containerized environment, following the principles of Infrastructure as Code (IaC).

## Features

- **Web Server**: Configured to serve a website or PHP application, encapsulated within its own container.
- **Database Server**: A separate container running a database service, such as MariaDB, isolated from the other services for security and performance.
- **Admin Interface**: Tooling like phpMyAdmin set up in another container, providing a web interface for database management.
- **Volume Management**: Persistent storage solutions for data retention across container restarts and deployments.
- **Network Configuration**: Custom Docker networks for inter-container communication, enhancing security and connectivity.
- **Security Practices**: Implementation of security best practices, such as environment variable management, secure passwords, and network policies.

## Dependencies

- Docker and Docker-compose: The project relies entirely on Docker for containerization and orchestration.
- Any Unix-based operating system (Linux preferred).

## Configuration

Before launching the project, you need to create a `.env` file at the root of the project directory to configure the environment variables required for the services. This file should include variables such as database passwords, user names, and any other configurations your services might need. Ensure you set `DOMAIN_NAME=localhost` in your `.env` file to properly configure the domain name for the services.

## Installation

1. **Clone the repository**:

    ```bash
    git clone git@github.com:akhellad/Inception.git
    ```

2. **Navigate to the project directory**:

    ```bash
    cd inception
    ```

3. **Create and configure your `.env` file as described in the Configuration section**.

    A template for the `.env` file might look like this:

    ```
    # Environment configuration
    DOMAIN_NAME=localhost
    MYSQL_ROOT_PASSWORD=examplepassword
    MYSQL_USER=exampleuser
    MYSQL_PASSWORD=exampleuserpassword
    MYSQL_DATABASE=exampledb
    ```

    Make sure to replace the placeholder values with your actual data.

4. **Launch the project**:

    Using the Makefile, you can build and start all the services with the configured environment variables.

    ```bash
    make all
    ```

    This command will initiate the Docker-compose process, which reads the `docker-compose.yml` and `.env` files, building the necessary Docker images, and starting up the containers as defined.

## Usage

After successfully launching the services:

- **Web Server**: Your web application will be accessible at `http://localhost`.
- **Admin Interface**: To manage the database, access the admin tool (like phpMyAdmin) at `http://localhost:<admin_port>`. Be sure to replace `<admin_port>` with the actual port number you configured in your `docker-compose.yml` file.

## Cleanup

To clean up your environment, you can use the Makefile commands designed for this purpose:

- **To stop and remove the containers, networks, and volumes**:

    ```bash
    make down
    ```

- **For a full cleanup, including removing all images used by the project**:

    ```bash
    make fclean
    ```

    This will ensure that all components related to the project are removed, freeing up your system resources.

## Credits

This project was meticulously developed by Ahmed Khelladi, as part of the 42 school curriculum. It's a demonstration of leveraging Docker and Docker-compose to craft a fully containerized web application environment, adhering to best practices in security and infrastructure management.
