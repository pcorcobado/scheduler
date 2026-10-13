resource "aws_vpc" "poc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "github-aws-oidc-poc-vpc"
  }
}

resource "aws_subnet" "certification" {
  vpc_id                  = aws_vpc.poc.id
  cidr_block              = var.certification_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name        = "github-aws-oidc-poc-certification"
    Environment = "certification"
  }
}

resource "aws_subnet" "preproduction" {
  vpc_id                  = aws_vpc.poc.id
  cidr_block              = var.preproduction_subnet_cidr
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name        = "github-aws-oidc-poc-preproduction"
    Environment = "preproduction"
  }
}

resource "aws_route_table" "isolated" {
  vpc_id = aws_vpc.poc.id

  tags = {
    Name = "github-aws-oidc-poc-isolated"
  }
}

resource "aws_route_table_association" "certification" {
  subnet_id      = aws_subnet.certification.id
  route_table_id = aws_route_table.isolated.id
}

resource "aws_route_table_association" "preproduction" {
  subnet_id      = aws_subnet.preproduction.id
  route_table_id = aws_route_table.isolated.id
}

resource "aws_security_group" "ec2" {
  name        = "github-aws-oidc-poc-ec2"
  description = "No inbound access required for the OIDC start/stop PoC."
  vpc_id      = aws_vpc.poc.id

  egress {
    description = "Allow outbound traffic within the VPC routing model."
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "github-aws-oidc-poc-ec2"
  }
}
