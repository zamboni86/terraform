output "subnet_id" {
  value = "${aws_subnet.public.id}"
}

output "subnet_cidr" {
  value = "${aws_subnet.public.cidr_block}"
}