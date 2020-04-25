provider "aws" {
  region = "ap-south-1"
}
data "aws_ami" "terra-ec2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

resource "aws_instance" "my-ec2" {
  ami                    = "${data.aws_ami.terra-ec2.id}"
  instance_type          = "t2.micro"
  subnet_id              = "${var.subnet_id}"
  key_name               = "demokey"
  vpc_security_group_ids = ["${var.security_group_id}"]
  count                  = 1

  tags = {
    Name = "${var.environment}-ec2"
  }
}
