locals {
  tags = {
    Environment = "${var.environment}",
    Access = "restricted"
  }
}

# define restricted subnet
resource "aws_subnet" "restricted" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr
  availability_zone = "${var.availability_zone}"

  tags = "${merge(
    local.tags,
    map(
      "Name", "${var.environment}-restricted-${var.availability_zone}"
    )
  )}"
}

# create route table
resource "aws_route_table" "restricted" {
  vpc_id = var.vpc_id
  
  tags = "${merge(
    local.tags,
    map(
      "Name", "${var.environment}-restricted-${var.availability_zone}"
    )
  )}"
}

resource "aws_route_table_association" "restricted" {
  subnet_id      = aws_subnet.restricted.id
  route_table_id = aws_route_table.restricted.id
}