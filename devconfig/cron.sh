#!/bin/bash

while true
do
    php /var/www/schedule.php 08E2D97A8041BA364CE58C1DD486A4E19901D38C8A0E3B0CADE5A94C7200C3 >> /var/log/schedule.log
    php /var/www/peerupdate.php 08E2D97A8041BA364CE58C1DD486A4E19901D38C8A0E3B0CADE5A94C7200C3 >> /var/log/peerupdate.log
    sleep 300
done
