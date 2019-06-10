FROM php:7.2-fpm

LABEL maintainer="philipp.kropp@gmail.com"

RUN apt-get update && apt-get upgrade -y \

     && apt-get -y install \
     #libxslt-dev \
     #libxml2-dev \
     #libbz2-dev \
     #libxpm-dev \
     #libvpx-dev \
     #libmemcached-dev \
     #libsodium-dev \
     #vim \
     #libmagickwand-dev \
     #libmcrypt-dev \

     # used from intl
     zlib1g-dev \
     libicu-dev \

     # needed from gd
     libjpeg62-turbo-dev \
     libpng-dev \
     libfreetype6-dev \

     # needed from contao-manager
     zip \

     && docker-php-ext-install \
         bcmath \
      #   calendar \
      #   exif \
      #   gettext \
      #   iconv \

      # optional for contao
         mbstring \
      #   mcrypt \
      #   mysqli \
         pdo_mysql \
      #   shmop \
      #   sockets \
      #   pcntl \
      #   wddx \
      #   xsl \
     && docker-php-ext-configure gd \
         --with-freetype-dir=/usr/include/ \
         --with-jpeg-dir=/usr/include/ \
         --with-png-dir=/usr/include/ \
     && docker-php-ext-install gd \
     && docker-php-ext-configure intl  \
     && docker-php-ext-install intl \
     && pecl install xdebug && docker-php-ext-enable xdebug \
     #&& pecl install redis && docker-php-ext-enable redis \
     #&& yes '' |
     #&& pecl install imagick
     #&& docker-php-ext-enable imagick

#USER www-data;
 # PHP 7.1

#    #php \
#    #curl \
#    vim \
#    libfreetype6-dev \
#    libjpeg62-turbo-dev \
#    libpq-dev \
#    libmagickwand-dev \
#    libmcrypt-dev \
#    libpng12-dev \
#    libmemcached-dev \
#    libssl-dev \
#    libssl-doc \
#    libsasl2-dev \
#    zlib1g-dev \
#    libicu-dev \
#    g++ \
#    && docker-php-ext-install \
#        bz2 \
#        iconv \
#        mbstring \
#        mcrypt \
#        mysqli \
#        pgsql \
#        pdo_mysql \
#        #pdo_pgsql \
#        soap \
#        zip \
#    && docker-php-ext-configure gd \
#        --with-freetype-dir=/usr/include/ \
#        --with-jpeg-dir=/usr/include/ \
#        --with-png-dir=/usr/include/ \
#    && docker-php-ext-install gd \
#    && docker-php-ext-configure intl  \
#    && docker-php-ext-install intl \
#    && pecl install xdebug && docker-php-ext-enable xdebug \
#    #&& pecl install mongodb && docker-php-ext-enable mongodb \
#    #&& pecl install redis && docker-php-ext-enable redis \
#    && yes '' | pecl install imagick && docker-php-ext-enable imagick

#        RUN mkdir -p /usr/local/bin;
#        RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony;
#        RUN chmod a+x /usr/local/bin/symfony;

#COPY ./contao.conf /etc/nginx/conf.d/default.conf

#RUN curl -sS https://getcomposer.org/installer | php
#RUN mv composer.phar /usr/local/bin/composer

#CMD ["/run.sh"]