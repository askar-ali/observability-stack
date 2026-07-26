.PHONY: check up down tf-validate
check:
	scripts/check-config.sh

up:
	docker compose up -d

down:
	docker compose down

tf-validate:
	cd terraform && terraform init -backend=false && terraform validate && terraform fmt -check
