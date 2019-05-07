#Generate keys & configs
../resources/scripts/ca_keygen.sh
../resources/scripts/admin_gen.sh
../resources/scripts/worker_keygen.sh
../resources/scripts/controller_manager_keygen.sh
../resources/scripts/proxy_keygen.sh
../resources/scripts/scheduler_keygen.sh
../resources/scripts/api_keygen.sh
../resources/scripts/service_account_keygen.sh






#Provision GCP Instances with terraform
terraform init
terraform plan
terraform apply

#Clean up deployment artifacts
