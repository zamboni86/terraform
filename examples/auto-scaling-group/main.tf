locals {
  environment = "example"
}

resource "aws_security_group" "allow_http" {
  name        = "${local.environment}-sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-02a81edeef982ea03"

  ingress {
    description = "test public access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

# get latest AMI
data "aws_ami" "example" {
  most_recent      = true

  owners = ["591542846629"] #AWS

  filter {
      name   = "name"
      values = ["amzn2-ami*"]
  }
}

resource "aws_launch_template" "template" {
  name = "example-template"

  image_id = "ami-0947d2ba12ee1ff75"

  instance_type = "t2.small"

  vpc_security_group_ids = [aws_security_group.allow_http.id]

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "test"
    }
  }

  //user_data = filebase64("./example.sh")
}
/*
module "launch-template" {
  source = "../../modules/auto-scaling/launch-template"
  
  name = "${local.environment}-template"
  security_group_id = aws_security_group.allow_http.id

}
*/
