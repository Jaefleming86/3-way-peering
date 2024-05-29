# Create subnets for VPC1
resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.vpc1.id
  cidr_block              = "10.86.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
}

# Create subnets for VPC2
resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.vpc2.id
  cidr_block              = "10.70.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
}

# Create subnets for VPC3
resource "aws_subnet" "public_subnet3" {
  vpc_id                  = aws_vpc.vpc3.id
  cidr_block              = "10.90.1.0/24"
  availability_zone       = "us-west-2a"
  map_public_ip_on_launch = true
}