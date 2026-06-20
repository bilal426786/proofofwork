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

# Install Redis PHP extension
RUN pecl install redis && docker-php-ext-enable redis

# Install opcache
RUN docker-php-ext-install opcache

# Install Composer
COPY --from=composer:2.8 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Copy composer files first for layer caching
COPY composer.json composer.lock* ./

# Install dependencies
RUN composer install --no-dev --optimize-autoloader --no-scripts --no-interaction

# Copy the rest of the application
COPY . .

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Generate app key and cache config
RUN php artisan key:generate --force 2>/dev/null || true

EXPOSE 9000
CMD ["php-fpm"]
