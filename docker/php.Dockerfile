FROM php:8.1-fpm

COPY "./app" "/var/www/app"

WORKDIR "/var/www/app"

RUN apt-get update && apt-get install -y \
        zip \
        unzip \
        libzip-dev \
    && pecl install redis \
    && pecl install zip \
    && docker-php-ext-enable redis \
    && docker-php-ext-enable zip

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

EXPOSE 9000
CMD ["php-fpm"]
