# debian jessie base
FROM debian:8.7

# upgrade distro and install wget
RUN apt-get update && apt-get -y dist-upgrade && apt-get install -y wget

# dotdeb needed for PHP7
RUN echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list.d/dotdeb.list
RUN wget -O- http://www.dotdeb.org/dotdeb.gpg | apt-key add -

# gazelle deps
RUN apt-get update && apt-get install -y git nginx mysql-client php7.0-fpm libmysql++-dev \
                       libmysqld-dev php7.0-mcrypt php7.0-mbstring \
                       php7.0-mysql php7.0-cli libpng-dev libmcrypt-dev \
                       libxml2-dev binutils libev-dev php-soap php-pear \
                       php7.0-curl php7.0-gd sendmail php7.0-apcu-bc php7.0-apcu

# install memcache module for php (need this one to support PHP7)
RUN wget http://ftp.us.debian.org/debian/pool/main/p/php-memcache/php-memcache_3.0.9~20160311.4991c2f-5_amd64.deb && dpkg -i *.deb && rm -rf *.deb

# nginx site config
ADD default /etc/nginx/sites-available/default

# clear out any existing web content (packaged w/ nginx)
RUN rm -rf /var/www/html

# create torrent storage dir
RUN mkdir /var/torrents

# access to the webserver
EXPOSE 80

ADD start.sh /start.sh
RUN chmod +x ./start.sh

# copy in keys
COPY docker.crt /etc/nginx/certs/docker.crt
COPY docker.key /etc/nginx/certs/docker.key
RUN chown -R www-data: /etc/nginx/certs

# start nginx / other web related processes
CMD ["./start.sh"]
