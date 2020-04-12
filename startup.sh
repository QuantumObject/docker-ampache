#!/bin/bash

set -e

if [ -f /etc/configured ]; then
        echo 'already configured'
else
        #code that need to run only one time ....
        if [[ ! -f /var/www/ampache/config/ampache.cfg.php ]]; then
          mv /var/temp/ampache.cfg.php.dist /var/www/ampache/config/ampache.cfg.php.dist
        fi
        chmod 770 /var/www/ampache/config -R
        chown -R www-data:www-data /var/www/ampache
    
       
        #needed for fix problem with ubuntu and cron
        update-locale 
        date > /etc/configured
fi
