FROM sebp/elk

MAINTAINER Dmitrii Zolotov <dzolotov@herzen.spb.ru>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y tzdata && \
    apt-get clean && \
    echo 'Europe/Moscow' >/etc/timezone && dpkg-reconfigure tzdata

RUN cd /etc/logstash && curl -O "http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz" && gunzip GeoLiteCity.dat.gz

ADD elasticsearch-template.json /etc/logstash/templates/elasticsearch-template.json

ADD ./elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

ADD ./*.pattern ${LOGSTASH_HOME}/patterns/

ADD *.conf /etc/logstash/conf.d/

