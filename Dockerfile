FROM php:5-apache

ARG BUILD_DATE
ARG VERSION
LABEL build_date="${BUILD_DATE}"
LABEL version="${VERSION}"

ENV INSTALL_LIST wget unzip libjpeg62-turbo-dev libfreetype6-dev
ENV PHP_EXT_LIST pdo pdo_mysql gd mysqli mysql

RUN apt-get update \
    && apt-get install -qy $INSTALL_LIST \
    && docker-php-ext-install $PHP_EXT_LIST \
    && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* /root/.cache \
    && a2enmod rewrite

ADD startup.sh /startup.sh
RUN chmod 777 /startup.sh

VOLUME ["/var/www/html"]
EXPOSE 80
CMD ["/startup.sh"]
