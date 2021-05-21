.PHONY: up up-prod build remake stop down restart rmi-local destroy \
				destroy-volumes ps \
				stg-init stg-plan stg-apply stg-destroy \
				prod-init prod-plan prod-apply prod-destroy check

up:
	docker compose up -d

up-prod:
	docker compose up -f docker-compose.prod.yml -d

build:
	docker compose build --no-cache --force-rm

remake:
	@make destroy
	@make init

stop:
	docker compose stop

down:
	docker compose down --remove-orphans

restart:
	@make down
	@make up

rmi-local:
	docker compose down --rmi local --remove-orphans

destroy:
	docker compose down --rmi all --volumes --remove-orphans

destroy-volumes:
	docker compose down --volumes --remove-orphans

ps:
	docker compose ps

stg-init:
	@docker compose run --rm terraform init

stg-plan:
	@docker compose run --rm terraform plan

stg-apply:
	@docker compose run --rm terraform apply

stg-destroy:
	@docker compose run --rm terraform destroy

prod-init:
	@docker compose run -f docker-compose.prod.yml --rm terraform init

prod-plan:
	@docker compose run -f docker-compose.prod.yml --rm terraform plan

prod-apply:
	@docker compose run -f docker-compose.prod.yml --rm terraform apply

prod-destroy:
	@docker compose run -f docker-compose.prod.yml --rm terraform destroy