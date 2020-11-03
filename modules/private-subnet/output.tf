output "subnet_id" {
  value = "${aws_subnet.private.id}"
}

output "subnet_cidr" {
  value = "${aws_subnet.private.cidr_block}"
}

output "route_table" {
  value = "${aws_route_table.private.id}"
}