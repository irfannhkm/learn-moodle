FROM php:8.3-apache

RUN apt-get update && \
    apt-get install -y --no-install-recommends unzip curl libzip-dev libjpeg-dev libpng-dev \
    libfreetype6-dev libicu-dev libxml2-dev libpq-dev && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install mysqli zip gd intl soap exif pgsql pdo_pgsql opcache && \
    pecl install redis && docker-php-ext-enable redis && \
    a2enmod rewrite && \
    curl -L https://download.moodle.org/download.php/direct/stable500/moodle-latest-500.tgz -o /tmp/moodle.tgz && \
    tar -xzf /tmp/moodle.tgz -C /tmp && \
    cp -a /tmp/moodle/. /var/www/html/ && \
    rm -rf /tmp/moodle /tmp/moodle.tgz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "max_input_vars=5000" >> /usr/local/etc/php/conf.d/docker-php-moodle.ini && \
    echo "opcache.enable=1" >> /usr/local/etc/php/conf.d/docker-php-opcache.ini && \
    echo "opcache.enable_cli=1" >> /usr/local/etc/php/conf.d/docker-php-opcache.ini && \
    echo "opcache.memory_consumption=256" >> /usr/local/etc/php/conf.d/docker-php-opcache.ini && \
    echo "opcache.interned_strings_buffer=16" >> /usr/local/etc/php/conf.d/docker-php-opcache.ini && \
    echo "opcache.max_accelerated_files=20000" >> /usr/local/etc/php/conf.d/docker-php-opcache.ini && \
    echo "opcache.revalidate_freq=60" >> /usr/local/etc/php/conf.d/docker-php-opcache.ini && \
    echo "opcache.validate_timestamps=1" >> /usr/local/etc/php/conf.d/docker-php-opcache.ini

COPY php.ini /usr/local/etc/php/php.ini

RUN mkdir -p /var/www/moodledata

WORKDIR /var/www/html

RUN chown -R www-data:www-data /var/www && \
    find /var/www -type d -exec chmod 755 {} \; && \
    find /var/www -type f -exec chmod 644 {} \;

EXPOSE 80