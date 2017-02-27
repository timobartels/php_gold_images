FROM debian:jessie

MAINTAINER Timo Bartels <timo@bartels-online.net>

LABEL "language"="php7" "type"="LAMP"

# Download and add GPG key for PHP7
RUN apt-get update && apt-get install -y wget

RUN echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list
RUN echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list

WORKDIR /tmp
RUN wget https://www.dotdeb.org/dotdeb.gpg && apt-key add dotdeb.gpg && rm dotdeb.gpg

# install packages for Apache and for compiling PHP
RUN apt-get update && apt-get install -y \
    apache2-mpm-prefork \
    apache2-prefork-dev \
    libapache2-mod-php7.0 \
    libphp7.0-embed \
    php7.0 \
    php7.0-cgi \
    php7.0-cli \
    php7.0-common \
    php7.0-fpm

# Remove default site and make your conf
RUN rm -f sites-enabled/000-default.conf
ADD apache-config.conf /etc/apache2/sites-enabled/000-default.conf

# Enable additional configs and mods
ENV HTTPD_PREFIX /etc/apache2
RUN a2dismod mpm_event && a2enmod mpm_prefork
RUN ln -s $HTTPD_PREFIX/mods-available/expires.load $HTTPD_PREFIX/mods-enabled/expires.load \
    && ln -s $HTTPD_PREFIX/mods-available/headers.load $HTTPD_PREFIX/mods-enabled/headers.load \
    && ln -s $HTTPD_PREFIX/mods-available/rewrite.load $HTTPD_PREFIX/mods-enabled/rewrite.load

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
