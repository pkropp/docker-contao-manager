# use makefile for handling project
Windows is not the best option for using makefile...

make 
start with downloading contao-manager
open localhost/contao-manager.phar.php for installing contao-manager and contao of your choice 

```docker-compose exec -T php /var/www/html/vendor/bin/contao-console contao:install-web-dir --user=USER --password=PASSWORD```

php vendor/bin/contao-console contao:install-web-dir --user=USER --password=PASSWORD

opening dev mode: [Contao dev](http://localhost/app_dev.php/contao)

Feedback: philipp.kropp@gmail.com

docker cleanup options:

``docker image prune``

delete images
``docker image prune -a``

delete all volumes

``docker volume prune``

list volumes
``docker volume ls``

``docker volume rm contao-mysql-data``

Settings for Contao Setup

localhost:     db
port:          keep default
database name: contao

