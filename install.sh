#!/usr/bin/env bash
if [ -z $1 ]; then
    echo "No repository to clone specified "
	exit 1
fi 

git clone $1 ./www 
docker-compose up -d

docker exec -it php php artisan storage:link 
docker exec -it php copy .env.docker .env 
docker exec -it php chmod -R 777 ./public 
docker exec -it php chmod -R 777 ./storage 
docker exec -it php chmod -R 777 ./bootstrap/cache 
docker exec -it php chmod -R 777 /etc/apache2/ssl
docker exec -it php composer install
docker exec -it php php artisan migrate --seed
docker exec -it php php artisan db:seed --class=PreviewSeeder

docker exec -it echo npm install 
docker exec -it echo npm run dev 
