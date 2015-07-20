#!/bin/bash
set -e

 /usr/bin/mysqld_safe &
 sleep 10s

 mysqladmin -u root password mysqlpsswd
 mysqladmin -u root -pmysqlpsswd reload
 mysqladmin -u root -pmysqlpsswd create  ampache

echo "GRANT ALL ON ampache.* TO ampacheuser@localhost IDENTIFIED BY 'ampachedbpasswd'; flush privileges; " | mysql -u root -pmysqlpsswd
 mysql -u ampacheuser -pampachedbpasswd ampache < /var/www/ampache/sql/ampache.sql


 #apache2 conf
 a2enmod rewrite
 chown -R www-data:www-data /var/www/ampache
 sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/ampache/' /etc/apache2/sites-enabled/000*.conf
 
 rm -R /var/www/html/
 
 #to fix error relate to ip address of container apache2
 echo "ServerName localhost" | sudo tee /etc/apache2/conf-available/fqdn.conf
 ln -s /etc/apache2/conf-available/fqdn.conf /etc/apache2/conf-enabled/fqdn.conf

 
#to clear some data before saving this layer ...a docker image
 apt-get clean
 rm -rf /tmp/* /var/tmp/*
 rm -rf /var/lib/apt/lists/*
 
killall mysqld
sleep 10s
