output "subnet_id" {
  value = "${aws_subnet.private.id}"
}

output "subnet_cidr" {
  value = "${aws_subnet.private.cidr_block}"
}