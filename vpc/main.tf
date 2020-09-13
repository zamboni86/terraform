# basic example for deploying a public, private and restricted subnet
module "vpc" {
  source = "../modules/vpc/"
  
  vpc_cidr = "10.0.0.0/16"
}