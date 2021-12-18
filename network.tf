#vpc
resource "aws_vpc" "longb_VPC" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "longb_VPC"
  }
}

#vpc internet gateway
resource "aws_internet_gateway" "longb_igw" {
  vpc_id = aws_vpc.longb_VPC.id

  tags = {
    Name = "longb_igw"
  }
}
#Subnet 1
resource "aws_subnet" "longb_subnet1" {
  vpc_id            = aws_vpc.longb_VPC.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"
  tags = {
    Name = "longb_subnet1"
  }
}
#Subnet 2 (RDS requires two subnets)
resource "aws_subnet" "longb_subnet2" {
  vpc_id            = aws_vpc.longb_VPC.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2b"
  tags = {
    Name = "longb_subnet2"
  }
}
#DB subnet group for RDS
resource "aws_db_subnet_group" "longb_subnet_grp" {
  name       = "longb_rds_subnet_grp"
  subnet_ids = [aws_subnet.longb_subnet1.id, aws_subnet.longb_subnet2.id]

  tags = {
    Name = "My DB subnet group"
  }
}
#ec2 security group
resource "aws_security_group" "longb_VPC_SG" {
  name        = "longb_sg1"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.longb_VPC.id

  ingress {
    description      = "MySQL Access"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.longb_VPC.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.longb_VPC.ipv6_cidr_block]
  }

  ingress {
    description      = "SSH Access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.longb_VPC.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.longb_VPC.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "longb_sg2"
  }
}

#ec2 network interface
resource "aws_network_interface" "longb_ec2NIC" {
  subnet_id       = aws_subnet.longb_subnet1.id
  private_ips     = ["10.0.1.15"]
  security_groups = [aws_security_group.longb_VPC_SG.id]

  tags = {
    Name = "longb_ec2NIC"
  }
}

#ec2 elastic ip (public ip)
resource "aws_eip" "longb_ec2_eis" {
  instance = aws_instance.longb_ec2.id
  vpc      = true
  tags = {
    Name = "longb_ec2_eis"
  }
}