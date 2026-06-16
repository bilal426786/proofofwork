FROM php:8.2-fpm-alpine

# Install system dependencies
RUN apk add --no-cache     curl     libpng-dev     libxml2-dev     zip     unzip     git     oniguruma-dev

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Install Composer
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html

# Copy composer files first for layer caching
COPY composer.json composer.lock* ./

# Install dependencies (without dev in production)
RUN composer install --no-dev --optimize-autoloader --no-scripts --no-interaction 2>/dev/null ||     composer install --optimize-autoloader --no-scripts --no-interaction

# Copy the rest of the application
COPY . .

# Set permissions
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Generate app key and optimize
RUN php artisan key:generate --force 2>/dev/null || true

EXPOSE 9000
CMD ["php-fpm"]
