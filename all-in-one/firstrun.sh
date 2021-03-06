#!/bin/bash

if [[ ! -f lib/nifi-corenlp-nar-1.0.nar ]]; then
    wget https://github.com/tspannhw/nifi-corenlp-processor/releases/download/v1.0/nifi-corenlp-nar-1.0.nar -O lib/nifi-corenlp-nar-1.0.nar
fi

docker-compose up -d