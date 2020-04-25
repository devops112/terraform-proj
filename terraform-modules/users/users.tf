resource "aws_iam_user" "my_iam_user" {
  name = "my-new-iam-user-${var.environment}"
}

provider "aws" {
  region = "ap-south-1"
}