#!/bin/bash

appdir=/var/www/html
installdir=$appdir/firewall
apache=/usr/local/bin/apache2-foreground

if [[ $(cat /etc/timezone) != "$TZ" ]] ; then
    echo "$TZ" > /etc/timezone
    dpkg-reconfigure -f noninteractive tzdata
    echo "date.timezone = $TZ" >> /usr/local/etc/php/conf.d/php.ini
fi

if [ ! -e $installdir ]; then
    echo Downloading Fever

    wget -O /tmp/fever.zip http://feedafever.com/gateway/public/fever.zip
    if [ $? -ne 0 ]; then
        echo Could not downolad installer... failing
        exit 1
    fi

    cd /var/www/html
    unzip -j /tmp/fever.zip
    rm /tmp/fever.zip
    chown -R www-data:www-data /var/www/html
fi

echo "Starting Apache2 ($apache)"
$apache
