FROM php:8.2-apache

# Instalá dependencias del sistema
RUN apt-get update && apt-get install -y \
    libzip-dev \
    libpng-dev \
    libxml2-dev \
    curl \
    unzip \
    git \
    && docker-php-ext-install pdo pdo_mysql mbstring zip gd xml bcmath

# Copiá el código
COPY . /var/www/html/

# Instalá Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instalá dependencias de PHP
WORKDIR /var/www/html
RUN composer install --no-dev --optimize-autoloader

# Ajustá permisos
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

CMD ["apache2-foreground"]
