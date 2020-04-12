#!/bin/bash

set -e


#in case Volume are empty
if [ "$(ls -A /var/www/ampache/config)" ]; then
    echo "config folder with data"    
else
    cp -Rp /var/backups/config/. /var/www/ampache/config/ 
    chmod 770 /var/www/ampache/config -R
fi

if [ "$(ls -A /var/www/ampache/themes)" ]; then
    echo "themes folder with data"    
else
    cp -Rp /var/backups/themes/. /var/www/ampache/themes/ 
    chmod 770 /var/www/ampache/themes -R
fi

# for first time startup.sh running....
if [ -f /etc/configured ]; then
        echo 'already configured'
else
        #code that need to run only one time ....  
        chown www-data:www-data /var/www/ampache
        #needed for fix problem with ubuntu and cron
        update-locale 
        date > /etc/configured
fi
