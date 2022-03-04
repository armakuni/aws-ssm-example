init:
	terraform -chdir=terraform init

plan:
	terraform -chdir=terraform plan -var-file ../config.tfvars

apply:
	terraform -chdir=terraform apply -var-file ../config.tfvars -auto-approve

destroy:
	terraform -chdir=terraform destroy -var-file ../config.tfvars -auto-approve
