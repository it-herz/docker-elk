FROM sebp/elk

MAINTAINER Dmitrii Zolotov <dzolotov@herzen.spb.ru>

ENV DEBIAN_FRONTEND noninteractive

ADD locale.gen /etc/

RUN apt-get update && apt-get install -y console-cyrillic locales tzdata && \
    echo 'Europe/Moscow' >/etc/timezone && dpkg-reconfigure tzdata && \
    export LANGUAGE=ru_RU.UTF-8 && export LANG=ru_RU.UTF-8 && export LC_ALL=ru_RU.UTF-8 && dpkg-reconfigure locales && \
    sed 's/# ru_RU.UTF-8 UTF-8/ru_RU.UTF-8 UTF-8/ig' -i /etc/locale.gen && locale-gen && update-locale && \
    apt-get clean && \
    echo "LC_ALL=ru_RU.UTF-8" >>/etc/bash.bashrc

ADD ./*.pattern ${LOGSTASH_HOME}/patterns/

ADD ./11-nginx.conf /etc/logstash/conf.d/11-nginx.conf

