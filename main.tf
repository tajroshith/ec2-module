resource "aws_instance" "webserver" {
    ami = var.ami_ids
    availability_zone = var.azone
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_security_group_ids = [ aws_security_group.main_sg.id ]
    tags = var.common-tags
}

resource "aws_security_group" "main_sg" {
  name = var.sg_name
  description = var.sg_description

  dynamic "ingress" {
    for_each = var.ingress
    content {
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
      description = ingress.value.description
    }
  }

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}