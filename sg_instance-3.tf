# Security groups for allowing traffic between VPCs 
resource "aws_security_group" "vpc1_sg" {
  vpc_id = aws_vpc.vpc1.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.vpc2.cidr_block, aws_vpc.vpc3.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "vpc2_sg" {
  vpc_id = aws_vpc.vpc2.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.vpc1.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "vpc3_sg" {
  vpc_id = aws_vpc.vpc3.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.vpc1.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Assign security groups to instances using vpc_security_group_ids
resource "aws_instance" "instance1" {
  ami                    = "ami-01cd4de4363ab6ee8"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet1.id
  vpc_security_group_ids = [aws_security_group.vpc1_sg.id]
}

resource "aws_instance" "instance2" {
  ami                    = "ami-01cd4de4363ab6ee8"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet2.id
  vpc_security_group_ids = [aws_security_group.vpc2_sg.id]
}

resource "aws_instance" "instance3" {
  ami                    = "ami-01cd4de4363ab6ee8"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public_subnet3.id
  vpc_security_group_ids = [aws_security_group.vpc3_sg.id]
}