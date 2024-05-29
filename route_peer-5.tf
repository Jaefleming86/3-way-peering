# Create Route Tables and Associations
resource "aws_route_table" "rtb1" {
  vpc_id = aws_vpc.vpc1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw1.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.rtb1.id
}

resource "aws_route_table" "rtb2" {
  vpc_id = aws_vpc.vpc2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw2.id
  }
}

resource "aws_route_table_association" "rta2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.rtb2.id
}

resource "aws_route_table" "rtb3" {
  vpc_id = aws_vpc.vpc3.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw3.id
  }
}

resource "aws_route_table_association" "rta3" {
  subnet_id      = aws_subnet.public_subnet3.id
  route_table_id = aws_route_table.rtb3.id
}

# Create VPC peering connections
resource "aws_vpc_peering_connection" "vpc1_to_vpc2" {
  vpc_id      = aws_vpc.vpc1.id
  peer_vpc_id = aws_vpc.vpc2.id
  auto_accept = true
}

resource "aws_vpc_peering_connection" "vpc3_to_vpc1" {
  vpc_id      = aws_vpc.vpc3.id
  peer_vpc_id = aws_vpc.vpc1.id
  auto_accept = true
}

# Create routes for VPC1
resource "aws_route" "route_vpc1_to_vpc2" {
  route_table_id            = aws_route_table.rtb1.id
  destination_cidr_block    = aws_vpc.vpc2.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_to_vpc2.id
}

resource "aws_route" "route_vpc1_to_vpc3" {
  route_table_id            = aws_route_table.rtb1.id
  destination_cidr_block    = aws_vpc.vpc3.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc3_to_vpc1.id
}

# Create routes for VPC3 to VPC1
resource "aws_route" "route_vpc3_to_vpc1" {
  route_table_id            = aws_route_table.rtb3.id
  destination_cidr_block    = aws_vpc.vpc1.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc3_to_vpc1.id
}

# Create routes for VPC2 to VPC1
resource "aws_route" "route_vpc2_to_vpc1" {
  route_table_id            = aws_route_table.rtb2.id
  destination_cidr_block    = aws_vpc.vpc1.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.vpc1_to_vpc2.id
}