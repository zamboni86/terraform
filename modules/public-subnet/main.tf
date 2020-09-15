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
      "Name", "public-${var.availability_zone}"
    )
  )}"
}

# create public route table
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  dynamic "route" {
    for_each = [for route in var.subnet_routes: {
      cidr_block = route
      gateway_id = var.igw_id
    }]
    content {
      cidr_block = route.value.cidr_block
      gateway_id = route.value.gateway_id
    }
  }

  tags = "${merge(
    local.tags,
    map(
      "Name", "public-route table"
    )
  )}"
}

# link subnet with route table
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}