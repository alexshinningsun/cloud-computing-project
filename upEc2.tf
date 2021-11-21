terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_instance" "app_server" {
  count = var.numOfEC2
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "${var.instance_name}-${count.index}"
  }
}
