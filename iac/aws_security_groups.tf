resource "aws_security_group" "default" {
  name        = local.sg_name
  description = "Segurity Group for ${local.sg_name} ${var.env} comunication"
  vpc_id      = aws_vpc.main.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}