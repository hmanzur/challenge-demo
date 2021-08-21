resource "aws_vpc" "main" {

  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(local.tags, {
    Name = local.vpc_name
  })
}

resource "aws_subnet" "eb" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"

  tags = local.tags
}

resource "aws_vpn_gateway" "vpn_gw" {
  vpc_id = aws_vpc.main.id

  tags = local.tags
}