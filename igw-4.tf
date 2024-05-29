# Create Internet Gateways
resource "aws_internet_gateway" "igw1" {
  vpc_id = aws_vpc.vpc1.id
}

resource "aws_internet_gateway" "igw2" {
  vpc_id = aws_vpc.vpc2.id
}

resource "aws_internet_gateway" "igw3" {
  vpc_id = aws_vpc.vpc3.id
}