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
  ami           = "ami-0c960b947cbb2dd16"
  instance_type = "t2.micro"
}
