AWS_ACCOUNT_NUM := $(shell aws sts get-caller-identity --query Account --output text)

.PHONY: build
build:
	aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin ${AWS_ACCOUNT_NUM}.dkr.ecr.us-east-1.amazonaws.com
	cd docker && docker build -t ${AWS_ACCOUNT_NUM}.dkr.ecr.us-east-1.amazonaws.com/factorio:latest .
	docker push ${AWS_ACCOUNT_NUM}.dkr.ecr.us-east-1.amazonaws.com/factorio:latest

.PHONY: deploy
deploy: build
	cd terraform && terraform init
	cd terraform && terraform apply
