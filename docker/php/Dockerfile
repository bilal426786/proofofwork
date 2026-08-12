# Shared Laravel/PHP-FPM Dockerfile for ALL apps/backend/* apps (idp, core, business).
# One file instead of 3 byte-identical copies. Select the app with:
#   docker build -f docker/php/Dockerfile --build-arg APP=idp .
#
# Build context is the REPO ROOT so this file can be reused per app via a
# build arg, same pattern as docker/frontend/Dockerfile.

FROM php:8.4-fpm-alpine

# Install system dependencies
RUN apk add --no-cache \
    curl \
    libpng-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    oniguruma-dev \
    icu-dev \
    linux-headers \
    autoconf \
    g++ \
    make

# Install PHP extensions
RUN docker-php-ext-install \
    pdo_mysql \
    mbstring \
    exif \
    pcntl \
    bcmath \
    gd \
    intl

# Install opcache
RUN docker-php-ext-install opcache

# Install Composer
COPY --from=composer:2.8 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

ARG APP
ENV APP=${APP}

# Copy composer files first for layer caching
COPY apps/backend/${APP}/composer.json apps/backend/${APP}/composer.lock* ./

# Install dependencies (predis/predis is a pure-PHP Redis client — see
# config/database.php's REDIS_CLIENT=predis — so no pecl redis extension needed)
RUN composer install --no-dev --optimize-autoloader --no-scripts --no-interaction

# Copy the rest of that one app
COPY apps/backend/${APP}/ .

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

EXPOSE 9000
CMD ["php-fpm"]
