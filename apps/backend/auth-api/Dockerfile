FROM php:8.3-fpm-alpine

# 1. Install essential system extensions for laravel
RUN apk add --no-cache \
    nginx \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    zip \
    libzip-dev \
    unzip \
    git \
    bash \
    postgresql-dev
# 2. Install required PHP extentions
RUN docker-php-ext-configure gd \
    --with-freetype \
    --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql gd zip bcmath

# 3. Get modern Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

# 4. Expose internal port
EXPOSE 80

# Start custom simple internal script to run background tasks
CMD composer install && php artisan serve --host=0.0.0.0 --port=80
