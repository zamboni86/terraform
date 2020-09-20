locals {
  tags = {
    Environment = "${var.environment}",
    Access = "private"
  }
}

# define private subnet
resource "aws_subnet" "private" {
  vpc_id = var.vpc_id
  cidr_block = var.subnet_cidr
  availability_zone = "${var.availability_zone}"

  tags = "${merge(
    local.tags,
    map(
      "Name", "${var.environment}-private-${var.availability_zone}"
    )
  )}"
}

#creating elastic ip address and NAT GWs for private subnet routing
resource "aws_eip" "private" {
  vpc      = true

  tags = "${merge(
    local.tags,
    map(
      "Name", "${var.environment}-nat"
    )
  )}"
}

resource "aws_nat_gateway" "private" {
  allocation_id = "${aws_eip.private.id}"
  subnet_id     = "${aws_subnet.private.id}"

  tags = "${merge(
    local.tags,
    map(
      "Name", "${var.environment}-${var.availability_zone}"
    )
  )}"
}

# create route table that's private
resource "aws_route_table" "private" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.private.id
  }
  
  tags = "${merge(
    local.tags,
    map(
      "Name", "${var.environment}-private-${var.availability_zone}"
    )
  )}"
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}