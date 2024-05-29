# Create VPCs
resource "aws_vpc" "vpc1" {
  cidr_block = "10.86.0.0/16"
  tags = {
    Name = "vpc1"
  }
}

resource "aws_vpc" "vpc2" {
  cidr_block = "10.70.0.0/16"
  tags = {
    Name = "vpc2"
  }
}

resource "aws_vpc" "vpc3" {
  cidr_block = "10.90.0.0/16"
  tags = {
    Name = "vpc3"
  }
}