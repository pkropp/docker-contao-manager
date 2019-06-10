ARGS = $(filter-out $@,$(MAKECMDGOALS))
# Makefile for Docker Nginx PHP Composer MySQL

include .env

# MySQL
MYSQL_DUMPS_DIR=data/db/dumps

help:
	@echo ""
	@echo "usage: make COMMAND"
	@echo ""
	@echo "Commands:"
	@echo "  fetch-contao-manager   Download Contao Manager file and add php ending"
	@echo "  mac-clean              Generate documentation of API"
	@echo "  mac-start          	start with docker-sync"
	@echo "  clean               Clean directories for reset"
	@echo "  composer-up         Update PHP dependencies with composer"
	@echo "  docker-start        Create and start containers"
	@echo "  docker-stop         Stop and clear all services"


init:
	make mac-clean fetch-contao-manager mac-start

fetch-contao-manager:
	#mkdir app/web
	@wget https://download.contao.org/contao-manager/stable/contao-manager.phar -P ./app/web
	@mv ./app/web/contao-manager.phar ./app/web/contao-manager.phar.php
	#@docker volume create --name contao-mysql-data

set-dev-login:
	@docker-compose exec -T php /var/www/html/vendor/bin/contao-console contao:install-web-dir --user=pkropp --password=testtest

	@docker-compose exec -T php ./app/vendor/bin/contao-console contao:install-web-dir --user=USER --password=PASSWORD
#php vendor/bin/contao-console contao:install-web-dir --user=USER --password=PASSWORD


#init:
	#@$(shell cp -n $(shell pwd)/web/app/composer.json.dist $(shell pwd)/web/app/composer.json 2> /dev/null)

apidoc:
	@docker-compose exec -T php ./app/vendor/bin/apigen generate app/src --destination app/doc
	@make resetOwner



clean:
	@rm -Rf data/db/mysql/*
	@rm -Rf $(MYSQL_DUMPS_DIR)/*
	@rm -Rf app
	@rm -Rf etc/ssl/*

code-sniff:
	@echo "Checking the standard code..."
	@docker-compose exec -T php ./app/vendor/bin/phpcs -v --standard=PSR2 app/src

activate-dev:
	@docker run --rm -v $(shell pwd)/web/app:/app

composer-up:
	@docker run --rm -v $(shell pwd)/web/app:/app composer update

docker-start: init
	docker-compose up -d

docker-stop:
	@docker-compose down -v
	@make clean

mac-clean:
	@docker-sync-stack clean

mac-start:
	@docker-sync-stack start

gen-certs:
	@docker run --rm -v $(shell pwd)/etc/ssl:/certificates -e "SERVER=$(NGINX_HOST)" jacoelho/generate-certificate

logs:
	@docker-compose logs -f

mysql-dump:
	@mkdir -p $(MYSQL_DUMPS_DIR)
	@docker exec $(shell docker-compose ps -q mysqldb) mysqldump --all-databases -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" > $(MYSQL_DUMPS_DIR)/db.sql 2>/dev/null
	@make resetOwner

mysql-restore:
	@docker exec -i $(shell docker-compose ps -q mysqldb) mysql -u"$(MYSQL_ROOT_USER)" -p"$(MYSQL_ROOT_PASSWORD)" < $(MYSQL_DUMPS_DIR)/db.sql 2>/dev/null

test: code-sniff
	@docker-compose exec -T php ./app/vendor/bin/phpunit --colors=always --configuration ./app/
	@make resetOwner

resetOwner:
	@$(shell chown -Rf $(SUDO_USER):$(shell id -g -n $(SUDO_USER)) $(MYSQL_DUMPS_DIR) "$(shell pwd)/etc/ssl" "$(shell pwd)/web/app" 2> /dev/null)

.PHONY: clean test code-sniff init