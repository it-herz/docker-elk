FROM sebp/elk

MAINTAINER Dmitrii Zolotov <dzolotov@herzen.spb.ru>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get install -y tzdata && \
    apt-get clean && \
    echo 'Europe/Moscow' >/etc/timezone && dpkg-reconfigure tzdata

ADD ./elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

ADD ./*.pattern ${LOGSTASH_HOME}/patterns/

ADD ./11-nginx.conf /etc/logstash/conf.d/11-nginx.conf
