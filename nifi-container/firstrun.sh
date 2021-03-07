#!/bin/bash

# copying .env-example to .env
if [[ ! -f .env ]]; then
    echo "========================================================"
    echo "* * * Please set your environment variable on .env * * *";
    echo "========================================================"
    echo " - Copying .env file from .env-example..."
    cp .env-example .env
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