# Dockerfile
FROM php:8.2-apache

# Instalá extensiones necesarias
RUN docker-php-ext-install pdo pdo_mysql

# Copiá el código al contenedor
COPY . /var/www/html/

# Instalá Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instalá dependencias de PHP
RUN composer install

# Ajustá permisos
RUN chown -R www-data:www-data /var/www/html

EXPOSE 80

CMD ["apache2-foreground"]
