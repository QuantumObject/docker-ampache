#!/bin/bash
set -e

 #apache2 conf
 a2enmod rewrite
 chmod 770 /var/www/ampache/config -R
 sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/ampache/' /etc/apache2/sites-enabled/000*.conf
 sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 200M/' /etc/php/7.2/apache2/php.ini 
 sed -i 's/post_max_size = 8M/post_max_size = 40M/' /etc/php/7.2/apache2/php.ini 
 rm -R /var/www/html/
 
 #copy the .htaccess 
cd /var/www/ampache
cp ./rest/.htaccess.dist ./rest/.htaccess
cp ./play/.htaccess.dist ./play/.htaccess
cp ./channel/.htaccess.dist ./channel/.htaccess
chown -R www-data:www-data /var/www/ampache
 
 #to fix error relate to ip address of container apache2
 echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf
 ln -s /etc/apache2/conf-available/fqdn.conf /etc/apache2/conf-enabled/fqdn.conf
 
 # create a backup for when using docker volume
 cp -Rp /var/www/ampache/config /var/backups
 cp -Rp /var/www/ampache/themes /var/backups
