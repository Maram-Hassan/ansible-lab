# Create a VPC
resource "aws_vpc" "myvpc" {
  cidr_block = var.cidr_vpc
  tags = {
    Name = "myvpc"
  }

}