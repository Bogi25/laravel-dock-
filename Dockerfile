FROM php:8.0.0-fpm
# FROM php:7.4-fpm

# Встановлення розширень PHP
RUN apt-get update && apt-get install -y \
        libpng-dev \
        libjpeg-dev \
        libpq-dev \
        libfreetype6-dev \
        zip \
        unzip \
        git \
        curl && \
    docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install -j$(nproc) gd pdo pdo_mysql pdo_pgsql

# Встановлення Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
COPY ./candle /var/www

# Копіювання коду додатку
RUN git clone https://github.com/rappasoft/laravel-boilerplate.git /var/www/boilerplate

RUN mv /var/www/boilerplate/.env.example /var/www/boilerplate/.env
# RUN rm /var/www/boilerplate/composer.lock
WORKDIR /var/www/boilerplate

# Порт, через який буде доступний додаток
EXPOSE 9000
# Команда для запуску
# ENTRYPOINT ["php-fpm"]
CMD ["php-fpm","-F"]
# CMD ["tail", "-f", "/dev/null"]