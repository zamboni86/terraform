output "subnet_id" {
  value = "${aws_subnet.public.id}"
}

output "subnet_cidr" {
  value = "${aws_subnet.public.cidr_block}"
}

output "igw_id" {
  value = "${aws_internet_gateway.igw.id}"
}

output "route_table" {
  value = "${aws_route_table.public.id}"
}