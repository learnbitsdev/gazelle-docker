#!/bin/bash

sed 's@short_open_tag = Off@short_open_tag = On@' -i /etc/php/7.0/fpm/php.ini
sed 's@display_errors = Off@display_errors = On@' -i /etc/php/7.0/fpm/php.ini
sed 's@short_open_tag = Off@short_open_tag = On@' -i /etc/php/7.0/cli/php.ini

php-fpm7.0 & nginx

# check for cron job script
if [ -f "/cron.sh" ]; then
    # run cron job script (should never exit)
    /cron.sh
else
    echo "No cron found. Running in infinite loop..."
    while true
    do
        sleep 300
    done
fi
