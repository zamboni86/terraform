locals {
  tags = {
    Environment = "${var.environment}"
  }
}

# create VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true

  tags = "${merge(
    local.tags,
    map(
      "Name", "${var.environment}-vpc"
    )
  )}"
}

# create internet gatway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = "${merge(
    local.tags,
    map(
      "Name", "${var.environment}-igw"
    )
  )}"
}