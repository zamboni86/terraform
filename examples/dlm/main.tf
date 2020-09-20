locals {
  environment = "example"
}

module "dlm-iam" {
  source = "../../modules/dlm-iam/"
}

module "dlm" {
  source = "../../modules/dlm/"
  execution_role_arn = module.dlm-iam.aws_role_arn
  name = "2 weeks of daily snapshots"
  interval = "24"
  interval_unit = "HOURS"
  times = "23:45"
  retain_rule_count = "14"

  target_tags = {
    daily-snapshot = "true",
    enviroment = "production",
    type = "database"
  }
}