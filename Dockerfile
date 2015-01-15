FROM ubuntu:latest

MAINTAINER Martin Wood-Mitrovski <martin.wood@gooii.com>

RUN apt-get update
RUN apt-get -y upgrade 

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apache2 libapache2-mod-php5 php5-xsl libapache2-mod-proxy-html

RUN a2enmod php5
RUN a2enmod rewrite
RUN a2enmod proxy
RUN a2enmod proxy_http

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
 
EXPOSE 80
 
# Copy site into place.
ADD dist /var/www/site
 
# Update the default apache site with the config we created.
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf
 
# By default, simply start apache.
CMD /usr/sbin/apache2ctl -D FOREGROUND


