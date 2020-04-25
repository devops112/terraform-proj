provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "terra-vpc" {
  cidr_block       = "${var.vpc_cidr}"
  instance_tenancy = "default"

  tags = {
    Name = "custom-terra-vpc"
  }
}

resource "aws_subnet" "terra-subnet" {
  vpc_id     = "${aws_vpc.terra-vpc.id}"
  cidr_block = "${var.subnet_cidr}"

  tags = {
    Name = "custom-terra-subnet-${var.environment}"
  }
}


resource "aws_security_group" "terra-sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "${aws_vpc.terra-vpc.id}"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.terra-vpc.cidr_block]
  }
  ingress {
    description = "ssh from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.terra-vpc.cidr_block]
  }
    ingress {
    description = "TLS from VPC"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.terra-vpc.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "custom-terra-sg-${var.environment}"
  }
}
