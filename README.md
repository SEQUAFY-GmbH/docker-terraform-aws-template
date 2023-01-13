# Terraform AWS container
This Docker container is used to provide all the necessary tools to roll out an AWS environment via Terraform.

Please makue sure to adjust the `aws_config` file prior to your needs, if you want to use AWS SSO or static access secrets.
## Build
Change into this directory and run the following command to build the Docker image.
```
docker build --tag terraform .
```
The version of Terraform can be changed per variable in the Docker build:
```
docker build --build-arg TF_VERSION="1.1.6" --tag terraform .
```
Please make sure to use a valid Terraform version:
https://releases.hashicorp.com/terraform/
## Start container
You can easily run the container and pull the Terraform directly in the container. If you have the code already checked out on your local filesystem, you can bind mount the according folder into the cotainer:
```
docker run -ti --rm -v `pwd`:/apps terraform
```
## Deploy code
From the pseudo tty of the container simply run terraform.
```
terraform <subcommand>
```