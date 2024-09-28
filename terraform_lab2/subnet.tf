resource "aws_subnet" "public_subnet_1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.cidr_public_subnet1
  availability_zone ="us-east-1a" 
  map_public_ip_on_launch = true
tags = {
    Name = "public_subnet_1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.cidr_public_subnet2
  availability_zone ="us-east-1b" 
  map_public_ip_on_launch = true
tags = {
    Name = "public_subnet_2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.cidr_private_subnet1
  availability_zone ="us-east-1a" 
  tags = {
    Name = "private_subnet_1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.myvpc.id
  cidr_block = var.cidr_private_subnet2
  availability_zone ="us-east-1b" 
  tags = {
    Name = "private_subnet_2"
  }

}
