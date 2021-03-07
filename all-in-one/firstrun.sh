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

# set heap init
NIFI_JVM_HEAP_INIT=$(cat .env | grep -i NIFI_JVM_HEAP_INIT | sed 's/NIFI_JVM_HEAP_INIT=//')
if [[ -z $NIFI_JVM_HEAP_INIT ]]; then
    DEFAULT_INIT=1G
    read -p "Please set your nifi heap init (default: 1G / 1024m): " INIT
    if [[ -z $INIT ]]; then
        INIT=$DEFAULT_INIT
    fi
    sed -i "s/NIFI_JVM_HEAP_INIT=/NIFI_JVM_HEAP_INIT=${INIT}/" .env
fi

# set heap max
NIFI_JVM_HEAP_MAX=$(cat .env | grep -i NIFI_JVM_HEAP_MAX | sed 's/NIFI_JVM_HEAP_MAX=//')
if [[ -z $NIFI_JVM_HEAP_MAX ]]; then
    DEFAULT_MAX=2G
    read -p "Please set your nifi heap init (default: 2G / 2048m): " MAX
    if [[ -z $MAX ]]; then
        MAX=$DEFAULT_MAX
    fi
    sed -i "s/NIFI_JVM_HEAP_MAX=/NIFI_JVM_HEAP_MAX=${MAX}/" .env
fi

if [[ ! -f lib/nifi-corenlp-nar-1.0.nar ]]; then
    wget https://github.com/tspannhw/nifi-corenlp-processor/releases/download/v1.0/nifi-corenlp-nar-1.0.nar -O lib/nifi-corenlp-nar-1.0.nar
fi

chmod -R 777 export
docker-compose up -d

echo "Waiting container twitter_mysql to be ready..."
sleep 20

MYSQL_CLIENT=$(which mysql)
if [[ -z $MYSQL_CLIENT ]]; then
    echo "Please install MySQL Client if you want to create default table. If you don't have already you can manually create table using file from sql/default.sql"
else
    mysql -u $MSYQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE -h 127.0.0.1 < ../sql/default.sql
fi