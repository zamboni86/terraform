locals {
  environment = "example"
}

data "aws_region" "current" {
  provider = aws
}

module "vpc" {
  source = "../../modules/vpc/"
  
  vpc_cidr = "10.0.0.0/16"
  
  environment = local.environment
}

module "private-subnet" {
  source = "../../modules/private-subnet/"
  
  vpc_id = "${module.vpc.vpc_id}"

  subnet_cidr = "10.0.10.0/24"

  availability_zone = "${data.aws_region.current.name}a"
  
  environment = local.environment
}