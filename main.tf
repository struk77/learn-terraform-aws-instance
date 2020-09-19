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

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    # values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "www-example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name = "awskey"
  provisioner "local-exec" {
    command = "bash create-host.sh ${aws_instance.www-example.public_ip} >> ${aws_instance.www-example.id}.yml"
  }
  provisioner "local-exec" {
    command = "sleep 10; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu --private-key ~/.ssh/awskey.pem -i '${aws_instance.www-example.id}.yml'  provisioning/site.yml; sleep 20; rm -rf '${aws_instance.www-example.id}.yml'"
  }
}