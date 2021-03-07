#!/bin/bash

# copying .env-example to .env
if [[ ! -f .env ]]; then
    echo "========================================================"
    echo "* * * Please set your environment variable on .env * * *";
    echo "========================================================"
    echo " - Copying .env file from .env-example..."
    cp .env-example .env
fi

# set root password
MYSQL_ROOT_PASSWORD=$(cat .env | grep -i MYSQL_ROOT_PASSWORD | sed 's/MYSQL_ROOT_PASSWORD=//')
if [[ -z $MYSQL_ROOT_PASSWORD ]]; then
    read -p "Please set your MySQL root password: " ROOT_PASSWORD
    sed -i "s/MYSQL_ROOT_PASSWORD=/MYSQL_ROOT_PASSWORD=${ROOT_PASSWORD}/" .env
fi

# set database
MYSQL_DATABASE=$(cat .env | grep -i MYSQL_DATABASE | sed 's/MYSQL_DATABASE=//')
if [[ -z $MYSQL_DATABASE ]]; then
    read -p "Please set your database: " DATABASE
    sed -i "s/MYSQL_DATABASE=/MYSQL_DATABASE=${DATABASE}/" .env
fi

# set username
MSYQL_USER=$(cat .env | grep -i MSYQL_USER | sed 's/MSYQL_USER=//')
if [[ -z $MSYQL_USER ]]; then
    read -p "Please set your user: " USER
    sed -i "s/MSYQL_USER=/MSYQL_USER=${USER}/" .env
fi

# set password
MYSQL_PASSWORD=$(cat .env | grep -i MYSQL_PASSWORD | sed 's/MYSQL_PASSWORD=//')
if [[ -z $MYSQL_PASSWORD ]]; then
    read -p "Please set your user password: " PASSWORD
    sed -i "s/MYSQL_PASSWORD=/MYSQL_PASSWORD=${PASSWORD}/" .env
fi

docker-compose up -d