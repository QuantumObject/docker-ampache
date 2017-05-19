#!/bin/bash

set -e

if [ -f /etc/configured ]; then
        echo 'already configured'
else
        #code that need to run only one time ....
        chmod 777 /var/www/ampache/config -R
        chown -R www-data:www-data /var/www/ampache
       
        #needed for fix problem with ubuntu and cron
        update-locale 
        date > /etc/configured
fi
