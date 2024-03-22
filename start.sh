#!/bin/bash
if ! docker ps &> /dev/null; then
        echo "Docker не запущений, буде запущенно"
        sudo systemctl start docker
fi
if [[ "$PWD" != *"laravel-dock-"* ]]; then
    # Перехід в папку laravel-dock-
    cd laravel-dock-
    echo -e "
    щоб зупинити контейнери перейдіть в папку laravel-dock- та
     вконайте команду docker-compose down.
    Це може виглядати так:
    cd laravel-dock- && docker-compose down\n"
fi
echo "виконую команду docker compose up -d"
docker compose up -d
sleep 5
docker ps
echo -e "\ncheck 4 containers should be running."