module "vpc" {
  source      = "../../terraform-modules/vpc"
  vpc_cidr    = "192.169.0.0/16"
  subnet_cidr = "192.169.1.0/24"
  environment = "qa"
  vpc_id      = "${module.vpc.vpc_id}"
}
module "instances" {
  source            = "../../terraform-modules/instances"
  environment       = "qa"
  subnet_id         = "${module.vpc.subnet_id}"
  vpc_id            = "${module.vpc.vpc_id}"
  security_group_id = "${module.vpc.security_group_id}"
  aws_key_pair      = "~/aws/aws_keys/demokey.pem"
}
