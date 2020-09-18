terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}

resource "aws_instance" "www-example" {
  ami           = "ami-0c960b947cbb2dd16"
  instance_type = "t2.micro"
  key_name = "deployer"
  provisioner "local-exec" {
    command = "echo '        ansible_host: ${aws_instance.www-example.public_ip}' >> provisioning/hosts.yml; sleep 30; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu --private-key ~/.ssh/deployer.pem -i provisioning/hosts.yml  provisioning/site.yml"
  }
}