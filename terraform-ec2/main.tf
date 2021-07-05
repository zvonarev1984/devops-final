terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.12.31"
}

provider "aws" {
  region = "eu-west-2"
}

#create new VPC
resource "aws_vpc" "new_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "vpc_new"
  }
}

# create the Subnet
resource "aws_subnet" "vpc_subnet" {
  vpc_id                  = aws_vpc.new_vpc.id
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = "true"
  availability_zone       = "eu-west-2a"

  tags = {
    Name = "subnet_vpc"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "vpc_gw" {
  vpc_id = aws_vpc.new_vpc.id
  tags = {
    Name = "gw_vpc"
  }
}

# Create Route Table
resource "aws_route_table" "vpc_route_table" {
  vpc_id = aws_vpc.new_vpc.id
  tags = {
    Name = "route_gw"
  }
}

# Create Internet Access
resource "aws_route" "vpc_internet_access" {
  route_table_id         = aws_route_table.vpc_route_table.id
  destination_cidr_block = var.dst_cidr_block
  gateway_id             = aws_internet_gateway.vpc_gw.id
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "vpc_association" {
  subnet_id      = aws_subnet.vpc_subnet.id
  route_table_id = aws_route_table.vpc_route_table.id
}

resource "aws_security_group" "web_allow_http_ssh" {
  name        = "allow_http_ssh"
  description = "Allow http and ssh inbound traffic"
  vpc_id      = aws_vpc.new_vpc.id

  ingress {
    description = "Ingress HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Ingress SSH"
    from_port   = 22
    to_port     = 22
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
    Name = "allow_http_and_ssh"
  }
}

resource "aws_instance" "web-server" {
  ami           = "ami-0194c3e07668a7e36"
  instance_type = "t2.micro"
  key_name      = "devopszvd"
  subnet_id     = aws_subnet.vpc_subnet.id
  #security_groups = ["ssh-access-vm", "allow_http"]
  vpc_security_group_ids = [aws_security_group.web_allow_http_ssh.id]

  tags = {
    Name    = "DevOpsTask"
    Billing = "Devops-test-instance"
  }
}
