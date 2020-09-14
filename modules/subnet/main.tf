locals {
  tags = {
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "public" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr
  availability_zone = "${var.availability_zone}"

  tags = "${merge(
    local.tags,
    map(
      "access", "public",
      "Name", "public-${var.availability_zone}"
    )
  )}"
}