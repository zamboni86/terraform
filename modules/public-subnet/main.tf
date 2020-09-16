locals {
  tags = {
    Environment = "${var.environment}",
    Access = "public"
  }
}

# define public subnet
resource "aws_subnet" "public" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr
  availability_zone = "${var.availability_zone}"

  tags = "${merge(
    local.tags,
    map(
      "Name", "${var.environment}-public-${var.availability_zone}"
    )
  )}"
}

# create route table that's publically accessible
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = "${merge(
    local.tags,
    map(
      "Name", "${var.environment}-public-${var.availability_zone}-route-table"
    )
  )}"
}

# link subnet with route table
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}