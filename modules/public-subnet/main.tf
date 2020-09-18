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

# create internet gatway (what allows the VPC to have access via the public internet)
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = "${merge(
    local.tags,
    map(
      "Name", "${var.environment}-igw"
    )
  )}"
}

# create route table that's publically accessible
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
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