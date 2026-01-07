provider "aws" {
    region = "us-east-1"
}

# 1.VPC
resource "aws_vpc" "vpc1" {
  cidr_block = "10.0.0.0/16"
    tags = {
        Name = "${var.client-name}-vpc"
        Managed-by = "${var.managed-by}"
    }
}

# 2.Internet Gateway
resource "aws_internet_gateway" "igw1" {
    vpc_id = aws_vpc.vpc1.id
    tags = {
        Name = "${var.client-name}-igw1"
        Managed-by = "${var.managed-by}"
    }    
}
# 3.Public Subnet 1
resource "aws_subnet" "public-subnet1" {
    vpc_id            = aws_vpc.vpc1.id
    cidr_block        = "10.0.1.0/24"
    tags = {
        Name = "${var.client-name}-public-subnet1"
        Managed-by = "${var.managed-by}"
    } 
}
# 4.Private Subnet 1
resource "aws_subnet" "private-subnet1" {
    vpc_id            = aws_vpc.vpc1.id
    cidr_block        = "10.0.2.0/24"
    tags = {
        Name = "${var.client-name}-private-subnet1"
        Managed-by = "${var.managed-by}"
    } 
}
# 5.Public Route Table 1
resource "aws_route_table" "public-rt1" {
    vpc_id = aws_vpc.vpc1.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw1.id
    }
    tags = {
        Name = "${var.client-name}-public-rt1"
        Managed-by = "${var.managed-by}"
    } 
}
# 6.Private Route Table 1
resource "aws_route_table" "private-rt1" {
    vpc_id = aws_vpc.vpc1.id
    tags = {
        Name = "${var.client-name}-private-rt1"
        Managed-by = "${var.managed-by}"
    } 
}
# 7.Public Route Table Association 1
resource "aws_route_table_association" "public-rt-assoc1" {
    subnet_id      = aws_subnet.public-subnet1.id
    route_table_id = aws_route_table.public-rt1.id
}
# 8.Private Route Table Association 1
resource "aws_route_table_association" "private-rt-assoc1" {
    subnet_id      = aws_subnet.private-subnet1.id
    route_table_id = aws_route_table.private-rt1.id
}
# 9.Security Group 1
resource "aws_security_group" "sg1" {
    name        = "${var.client-name}-sg1"
    # description = "Security group1 for ${var.client-name}"
    vpc_id      = aws_vpc.vpc1.id

    ingress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["36.255.17.21/32", aws_vpc.vpc1.cidr_block]
    }
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["36.255.17.21/32", aws_vpc.vpc1.cidr_block]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "${var.client-name}-sg1"
        Managed-by = "${var.managed-by}"
    }
}
# 10.Ec2 Instance 1
resource "aws_instance" "web1" {
    ami                         = "ami-0ecb62995f68bb549"
    instance_type               = "t3.micro"
    subnet_id                   = aws_subnet.public-subnet1.id
    key_name                    = "AWS-Demo"
    associate_public_ip_address = "true"
    vpc_security_group_ids      = [aws_security_group.sg1.id]

    tags = {
        Name = "${var.client-name}-web1"
        Managed-by = "${var.managed-by}"
    }
}
# 11.Ec2 Instance 2
resource "aws_instance" "db1" {
    ami                         = "ami-0ecb62995f68bb549"
    instance_type               = "t3.micro"
    subnet_id                   = aws_subnet.private-subnet1.id
    key_name                    = "AWS-Demo"
    associate_public_ip_address = "false"
    vpc_security_group_ids      = [aws_security_group.sg1.id]

    tags = {
        Name = "${var.client-name}-db1"
        Managed-by = "${var.managed-by}"
    }
}

output "web1-public-ip" {
    value = aws_instance.web1.public_ip 
}
output "web1-private-ip" {
    value = aws_instance.web1.private_ip
}
output "db1-private-ip" {
    value = aws_instance.db1.private_ip
}

