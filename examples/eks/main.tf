locals {
  environment = "example"
  cluster_name = "example"
}

module "my-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-cluster"
  cluster_version = "1.17"
  subnets         = ["subnet-003bd54b5bb33cec6", "subnet-00bcbaa398cb71ace"]
  vpc_id          = "vpc-0e0f2c2d2a6f5bfb8"

  worker_groups = [
    {
      instance_type = "t3.small"
      asg_max_size  = 2
      asg_desired_capacity = 2
    }
  ]
}