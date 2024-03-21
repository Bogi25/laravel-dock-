#!/bin/bash
sleep 50

echo "почали виконувати дії php"
COMPOSER_ALLOW_SUPERUSER=1
rm /var/www/boilerplate/composer.lock
# переходимо в папку з проектом
cd /var/www/boilerplate
# встановлення залежностей
composer self-update
composer self-update --2.2 
composer install --no-interaction

#встановлюємо ключ
php artisan key:generate

php artisan migrate

php artisan db:seed

php artisan storage:link

# sleep 3600

echo "команди виконано"
ls -la storage/logs/
php-fpm -F