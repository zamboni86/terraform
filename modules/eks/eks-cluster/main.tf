data "aws_eks_cluster" "cluster" {
  name = module.my-cluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.my-cluster.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

module "my-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-cluster"
  cluster_version = "1.17"
  subnets         = ["subnet-0342f82643c0103da", "subnet-0a83b74affb6a312d", "subnet-0d21e83c83a893ce4"]
  vpc_id          = "vpc-0b9c208a584271efa"

  worker_groups = [
    {
      instance_type = "t3.small"
      asg_max_size  = 1
    }
  ]
}