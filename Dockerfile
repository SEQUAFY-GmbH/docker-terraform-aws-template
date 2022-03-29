FROM ubuntu

ARG TF_VERSION="1.1.7"
ENV tfversion=$TF_VERSION

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y curl unzip pip git vim jq

# Terraform
# https://www.terraform.io/
RUN echo "${tfversion}"
RUN curl "https://releases.hashicorp.com/terraform/$TF_VERSION/terraform_${tfversion}_linux_amd64.zip" -o "/tmp/terraform_${tfversion}_linux_amd64.zip"
RUN unzip "/tmp/terraform_${tfversion}_linux_amd64.zip" -d /tmp/ && rm "/tmp/terraform_${tfversion}_linux_amd64.zip"
RUN mv /tmp/terraform /usr/bin/terraform

# AWS CLI
# https://aws.amazon.com/cli/
RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o /tmp/awscliv2.zip
RUN unzip /tmp/awscliv2.zip -d /tmp/
RUN /tmp/aws/install
RUN mkdir /root/.aws
COPY aws_config /root/.aws/config
RUN rm /tmp/awscliv2.zip
RUN rm -rf /tmp/aws

# Git remote codecommit
# https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-git-remote-codecommit.html
RUN pip3 install --no-cache-dir git-remote-codecommit

# pre-commit
# https://pre-commit.com/
RUN pip3 install --no-cache-dir pre-commit

# terraform-docs
# https://terraform-docs.io/
RUN curl -L "$(curl -s https://api.github.com/repos/terraform-docs/terraform-docs/releases/latest | grep -o -E -m 1 https://.+?-linux-amd64.tar.gz)" > terraform-docs.tgz
RUN tar -xzf terraform-docs.tgz terraform-docs
RUN rm terraform-docs.tgz
RUN chmod +x terraform-docs
RUN mv terraform-docs /usr/bin/


RUN mkdir /apps

WORKDIR /apps
CMD /bin/bash