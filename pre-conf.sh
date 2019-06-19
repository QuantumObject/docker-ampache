#!/bin/bash
set -e

 #apache2 conf
 a2enmod rewrite
 chmod 777 /var/www/ampache/config -R
 chown -R www-data:www-data /var/www/ampache
 sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/ampache/' /etc/apache2/sites-enabled/000*.conf
 sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 200M/' /etc/php/7.2/apache2/php.ini 
 sed -i 's/post_max_size = 8M/post_max_size = 40M/' /etc/php/7.2/apache2/php.ini 
 rm -R /var/www/html/
 
 #install ampache dependence using composer
 #install composer first
 cd /var/www/ampache
 php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
 php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === '48e3236262b34d30969dca3c37281b3b4bbe3221bda826ac6a9a62d6444cdb0dcd0615698a5cbe587c3f0fe57a54d8f5') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
 php composer-setup.php
 php -r "unlink('composer-setup.php');"
 mv composer.phar /usr/local/bin/composer
 composer install
 
 #to fix error relate to ip address of container apache2
 echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf
 ln -s /etc/apache2/conf-available/fqdn.conf /etc/apache2/conf-enabled/fqdn.conf
