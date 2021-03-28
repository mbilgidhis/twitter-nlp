# Twitter Sentiment Analysis

## Stop Here
<strong>Beware!!! If you use mobile data, please stop. When starting this project, it will consume at least 3GB of your data package. I know some of you are `fakir bandwidth` especially yodha aka semoet.</strong>

## Introduction
This repository is an introduction for how sentiment analysis works using Apache Nifi as processor, MySQL as database storage, and Grafana for showing result. It needs docker to be installed on your machine, but if you prefer to install Apache Nifi, MySQL Server, and Grafana manually without docker by yourself, please feel free to do it. What you need to do are:
* Download `core nlp processor` as I mentioned below, and put it in `lib` folder on your Apache Nifi installation.
* Modify `all-in-one/grafana.ini` as you need.
* As we used MySQL as our database, you might need to download MySQL driver which had already included in this repository. Please check `all-in-on/lib` folder.
* Add `grafana-piechart-panel` plugins for Grafana installation which had already been included in `all-in-one/plugins` folder.
* Base table is prepared in `sql` folder.
* Grafana dashboard and Nifi template can be used directly on your instalation.

If there's some mistakes or maybe you want to contribute, feel free to fork and pull request.

## Preparation
If you want to hassle free implementing or just trying, go to folder `all-in-one` and run `firstrun.sh`. It will ask you to fill the required environment variable.

If you want to do them one by one, go to each folder copy `.env-example` to `.env`, then fill the variable (except for `sql` folder, it contains base table structure which is required to store the data. Please don't forget to import the table if you do `docker-compose up -d` manually. Read last step on `firstrun.sh`, and make sure you have `mysql` client installed on your workstation).

Feel free to edit `docker-compose.yml` as needed.

## Twitter Developer Account
* Open [this link](https://developer.twitter.com/en/apply-for-access) to register an account. Please make sure that you have already registered your phone number to your Twitter account.
* Choose whatever role you like, I prefer `hobbyist`.
* Complete form to be able to access the api (it may take a while, since Twitter need you to fill every required form).
* All keys you need are,
  
  * API Key
  * API Secret Key
  * Access token
  * Access token secret
  * Bearer token (not really required)

## Next Step
All basic environment is ready right now, next step you need to import nifi project and grafana dashboard.

### Apache Nifi
You can access nifi from http://[your workstation ip]:8080/nifi or http://icube-nifi.ddns.net:8080 if you want access my server (it will be available when I am presenting). It takes times to be ready when you first install container. Be patient. 

Apache Nifi is an open source software for automating and managing the data flow between systems. It is a powerful and reliable system to process and distribute data. It provides web-base User Interface to create, monitor, and control data flows. It has a highly configurable modifiable data flow process to modify data at runtime<sup>[1](https://github.com/mbilgidhis/twitter-nlp#notes)</sup>. For more information about Apache Nifi you can read in [this link](https://nifi.apache.org/). 

For this project, we need `core nlp processor` library, which has already included to be downloaded when you run `firstrun.sh`. Buf if you prefer download it manualy you can check [this link](https://github.com/tspannhw/nifi-corenlp-processor), and check on release page. I use version 1.0 in this project. If you want, you can use updated version which is 1.6 (when this `readme` was created).

Whenever `twitter_nifi` (or whatever name you change in docker-compose.yml) is already started correctly which takes time like I already said before, you can import template which I already prepared for this project. File template is [`Twitter_Analysis.xml`](https://github.com/mbilgidhis/twitter-nlp/blob/master/Twitter_Analysis.xml). Step by step to import the template, please open [this link](https://docs.cloudera.com/HDPDocuments/HDF3/HDF-3.1.1/bk_user-guide/content/Import_Template.html). If you want to understand about Apache Nifi interface, please take a look to [this link](https://docs.cloudera.com/HDPDocuments/HDF3/HDF-3.1.1/bk_user-guide/content/User_Interface.html).

After you successfully import template, you can insert template by drag and drop `Template` button to working area. You can find `Template` button on `Components Toolbar` area. 

If you successfully insert template, Apache Nifi dashboard will look like this

![Nifi Panel](https://github.com/mbilgidhis/twitter-nlp/blob/master/images/nifi-panel.png)

You need to enable `Controller Service`. To access `Controller Service`, please click on anywhere except on `Processor`, then click symbol ⚙️. There are 3 `Controller Service` on this project,

* DBCPConnectionPool - MySQL
* JsonRecordSetWriter
* JsonTreeReader

You can enable them by clicking ⚡ symbol on each `Controller Service`. Especially for `DBCPConnectionPool - MySQL` you need to configure correct properties first. You need to fill value respectively based on your MySQL Server configuration

![MySQL Configuration](https://github.com/mbilgidhis/twitter-nlp/blob/master/images/mysql-controller.png)

After you enable the `Controller Service`, you need to fill token you got from `Twitter Developer` to get user tweet. Open `Get Twitter Process` group by double clicking it, and open `Get Twitter`

![Get Twitter Configuration](https://github.com/mbilgidhis/twitter-nlp/blob/master/images/twitter-processor.png)

You can configure the other properties as you required, like `Term to Filter On` if you want to filter based on hastag or search term.

In this project we need to create a variable which will be saved as `filter` on our table. Since field `Term to Filter On` can't be `expression language`, we need to fill filter twice on variable and `Term to Filter On`. You can create variable by right clicking empty space on workspace, and select `Variables`, create variable named `filter`. Fill variable with any filter you like, which needs to be same value with `Term to Filter On` field in `Get Twitter` process properties. Or if you prefer not to create variable, go to `Update Record` processor, and change `${filter}` on `/filter` custom properties to your preferred filter .

### Grafana
You can access Grafana from http://[your workstation ip]:3000/ or http://icube-grafana.ddns.net:8080 if you want access my server (it will be available when I am presenting).

Grafana is an open source solution for running data analytics, pulling up that make sense of the massive amount of data and to monitor our apps with the help of customizable dashboards<sup>[2](https://github.com/mbilgidhis/twitter-nlp#notes)</sup>. For more information about Grafana you can open [this link](https://grafana.com/).

This project use `sqlite` for Grafana storage configuration. You don't need to configure anything to run this project. Just run the container and import the dashboard. If you prefer to use another storage like `MySQL` or `Postgre`, you need to configure `grafana.ini` below `[database]` segment to db you prefer with its configuration. But please prepare db by yourself.

Whenever `twitter_grafana` (or whatever name you change on docker-compose.yml) is already started correctly, you need to create new datasource which refer to our `twitter_mysql` container. You can access the configuration by hovering ⚙️ symbol and choose `Data Sources`. Create new data source based on `MySQL`, fill required field as shown below (please refer on configuration you create when starting the project).

![Twitter Datasource Configuration](https://github.com/mbilgidhis/twitter-nlp/blob/master/images/twitter-datasource.png)

As you finish the configuration, save it and then import new dashboard which I already had been prepared for this project, [`Sentiment_Dashboard-1615116909628.json`](https://github.com/mbilgidhis/twitter-nlp/blob/master/Sentiment_Dashboard-1615116909628.json). Hover on `+` symbol and choose `Import`. You can choose by copy and paste content of file or by uploading the file. If you successfully import the dashboard, our recently imported dashboard will look like this

![Grafana Dashboard](https://github.com/mbilgidhis/twitter-nlp/blob/master/images/grafana-dashboard.png)

As we finished our configuration. We can start our step to run our workflow.

## Notes:

1. https://www.guru99.com/apache-nifi-tutorial.html
2. https://www.8bitmen.com/what-is-grafana-why-use-it-everything-you-should-know-about-it/