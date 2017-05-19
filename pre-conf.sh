#!/bin/bash
set -e

 #apache2 conf
 a2enmod rewrite
 chmod 777 /var/www/ampache/config -R
 chown -R www-data:www-data /var/www/ampache
 sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/ampache/' /etc/apache2/sites-enabled/000*.conf
 sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 200M/' /etc/php5/apache2/php.ini
 sed -i 's/post_max_size = 8M/post_max_size = 40M/' /etc/php5/apache2/php.ini
 rm -R /var/www/html/
 
 #install ampache dependence using composer
 #install composer first
 cd /var/www/ampache
 php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
 php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
 php composer-setup.php
 php -r "unlink('composer-setup.php');"
 mv composer.phar /usr/local/bin/composer
 composer install
 
 #to fix error relate to ip address of container apache2
 echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf
 ln -s /etc/apache2/conf-available/fqdn.conf /etc/apache2/conf-enabled/fqdn.conf
