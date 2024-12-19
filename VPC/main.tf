# VPC Creation
resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.vpc_name}"
  }
}

# SUBNETs Creation
resource "aws_subnet" "public_subnet" {
  vpc_id = var.vpc_id
  count = length(var.pub_sub_cidr)
  cidr_block = var.pub_sub_cidr[count.index]
  availability_zone = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public_Subnet-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id = var.vpc_id
  count = length(var.pvt_sub_cidr)
  cidr_block = var.pvt_sub_cidr[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = {
    Name = "Private_Subnet-${count.index + 1}"
  }
}

# IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.igw_name}"
  }
}

# EIP
resource "aws_eip" "Eip" {
  tags = {
    Name = "${var.eip_name}"
  }
}

# NGW
resource "aws_nat_gateway" "ngw" {
  # subnet_id = aws_subnet.public_subnet[1].id
  subnet_id = element(var.subnetids, var.index)
  allocation_id = aws_eip.Eip.id
  tags = {
    Name = "${var.ngw_name}"
  }

}

# ROUTE TABLEs Creation
# Public Route Table
resource "aws_route_table" "public_route_table" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.pubrt_name}"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

#Public Route Table Association with Public Subnets
resource "aws_route_table_association" "pubrt_association" {
  count = length(var.public_subnet)
  subnet_id = var.public_subnet[count.index]
  route_table_id = aws_route_table.public_route_table.id
}

# Private Route Table
resource "aws_route_table" "private_route_table" {
  vpc_id = var.vpc_id
  tags = {
    Name = "${var.pvtrt_name}"
  }
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
}

# Private Route Table Association with private subnets
resource "aws_route_table_association" "pvtrt_association" {
  count = length(var.private_subnet)
  subnet_id = var.private_subnet[count.index]
  route_table_id = aws_route_table.private_route_table.id
}