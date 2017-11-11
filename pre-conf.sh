#!/bin/bash
set -e

 #apache2 conf
 a2enmod rewrite
 chmod 777 /var/www/ampache/config -R
 chown -R www-data:www-data /var/www/ampache
 sed -i 's/DocumentRoot \/var\/www\/html/DocumentRoot \/var\/www\/ampache/' /etc/apache2/sites-enabled/000*.conf
 sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 200M/' /etc/php/7.0/apache2/php.ini 
 sed -i 's/post_max_size = 8M/post_max_size = 40M/' /etc/php/7.0/apache2/php.ini 
 rm -R /var/www/html/
 
 #install ampache dependence using composer
 #install composer first
 cd /var/www/ampache
 php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php
 php -r "if (hash('SHA384', file_get_contents('composer-setup.php')) === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
 php composer-setup.php
 php -r "unlink('composer-setup.php');"
 mv composer.phar /usr/local/bin/composer
 composer install
 
 #to fix error relate to ip address of container apache2
 echo "ServerName localhost" | tee /etc/apache2/conf-available/fqdn.conf
 ln -s /etc/apache2/conf-available/fqdn.conf /etc/apache2/conf-enabled/fqdn.conf
