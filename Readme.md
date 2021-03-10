# Twitter Sentiment Analysis
## Introduction
This repository is an introduction for how sentiment analysis works using Apache Nifi as processor, MySQL as database storage, and Grafana for showing result.

If there's some mistakes or maybe you want to contribute, feel free to fork and pull request.

## Preparation
If you want to hassle free implementing or just trying, go to folder `all-in-one` and run `firstrun.sh`. It will ask you to fill the required environment variable.

If you want to do them one by one, go to each folder copy `.env-example` to `.env`, then fill the variable (except for `sql` folder, it contains base table structure which is required to store the data. Please don't forget to import the table if you do `docker-compose up -d` manually. Read last step on `firstrun.sh`, and make sure you have `mysql` client installed on your workstation).

Feel free to edit `docker-compose.yml` as needed.

## Next Step
All basic environment is ready right now, next step you need to import nifi project and grafana dashboard.

### Nifi
You can access nifi from http://[your workstation ip]:8080/nifi or http://icube-nifi.ddns.net:8080 if you want access my server (it will be available when I am presenting).

to be continued...

### Grafana
You can access Grafana from http://[your workstation ip]:3000/ or http://icube-grafana.ddns.net:8080 if you want access my server (it will be available when I am presenting).

to be continued...