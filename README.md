# k8s The Hard Way - Terraform Provisioning


This repo contains terraform definitions for provisioning all the necessary networking and compute resources to do Kelsey Hightower's "Kubernets The Hard Way" ( https://github.com/kelseyhightower/kubernetes-the-hard-way )


### Networking

Creates the following resources:
- A VPC
- 2 subnets, one public for the jumpbox and one private
- 



### Compute


### Security
- An SSH keypair is automatically generated
    - you can get it's private key with:
       - `terraform output -raw ssh_private_key_pem > ./ssh-private.pem` 
       - don't forget to `chmod 400 ./ssh-private.pem` so the SSH cli will let you use it