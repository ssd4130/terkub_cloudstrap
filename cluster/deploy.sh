#Generate keys & configs
resources/scripts/ca_keygen.sh
sleep 1
resources/scripts/admin_gen.sh




#Provision GCP Instances with terraform
terraform init
terraform plan
terraform apply

#Clean up deployment artifacts
