variable "subnet_cidr" {}
variable "subnet_routes" {}

variable "vpc_id" {}
variable "igw_id" {}

variable "availability_zone" {
  type = string
}

variable "environment" {
  type = string
}