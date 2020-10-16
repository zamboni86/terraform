locals {
  environment = "example"
}

module "eks-iam" {
  source = "../../modules/eks/eks-iam/"

  role_name = "${local.environment}-eks-role"
}

module "eks-cluster" {
  source = "../../modules/eks/eks-cluster/"
}