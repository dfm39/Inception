# Inception

Welcome to school 42'2 Inception project! In this assignment, we'll dive into Docker and system administration by setting up a small infrastructure composed of different services. The goal is to create a highly configurable and efficient environment using Docker containers.


## Table of Contents
- [Get Started](#get-started)
- [Introduction](#chapter-i-general-introduction)
- [General Guidelines](#chapter-ii-general-guidelines)
- [Subject](#chapter-iii-general-subject)
- [Additions](#additions)
- [Project Structure](#project-structure)

## Get Started
1. **Configure .env File:** Navigate to the `srcs` folder and set up your credentials by copying the `env_to_edit` file to `.env`:

    ```sh
    cd srcs
    cp env_to_edit .env
    ```

   Edit the `.env` file with your chosen credentials.

2. **Build and Run Containers:** Launch the Docker containers by executing the following command:

    ```sh
    make up
    ```

   This command will establish the necessary containers and volumes.

3. **Access the Website:** Open your web browser and visit `https://dfranke.42.fr`, making sure to replace `dfranke` with your login.

4. **Shut Down Containers:** When you're finished, shut down the containers using:

    ```sh
    make down
    ```

   Optionally, you can use `make clean_volumes` and `make clean_host` for additional cleanup.

5. **Complete Cleanup and Rebuild:** For a complete cleanup of Docker resources and a fresh start, use:

    ```sh
    make re

## Chapter I Introduction

This project aims to broaden your knowledge of system administration by using Docker. You will virtualize several Docker images, creating them in your new personal virtual machine.

## Chapter II General Guidelines

- This project needs to be done on a Virtual Machine.
- All the files required for the configuration of your project must be placed in a `srcs` folder.
- A `Makefile` is also required and must be located at the root of your directory. It must set up your entire application (i.e., it has to build the Docker images using `docker-compose.yml`).

## Chapter III Subject

This project consists of setting up a small infrastructure composed of different services under specific rules. The entire project has to be completed in a virtual machine using Docker Compose. Each Docker image must have the same name as its corresponding service, and each service has to run in a dedicated container.

### Additions

- Using `network: host` or `--link` is forbidden.
- Containers must not be started with a command running an infinite loop.
- For obvious security reasons, any credentials, API keys, environment variables, etc., must be saved locally in a `.env` file and ignored by Git.
- Each Docker image must be built from the penultimate stable version of Alpine or Debian.
- Docker images must be built using your own Dockerfiles; pulling ready-made images or using DockerHub services is forbidden.
- The NGINX container serves as the entry point into your infrastructure via port 443, using the TLSv1.2 or TLSv1.3 protocol.

### By dmf39 (alias dfranke)