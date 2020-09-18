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

resource "aws_instance" "example" {
  ami           = "${data.aws_ami.latest_ubuntu.id}"
  instance_type = "t2.micro"
}