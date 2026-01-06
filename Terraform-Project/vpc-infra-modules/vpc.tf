# Create VPC using terraform aws vpc module
provider "aws" {
    region = "us-east-1"
}
########### vpc-1 ##############
module "vpc1" {
  source = "terraform-aws-modules/vpc/aws"

  name = "filpkart-vpc-dev"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
resource "aws_security_group" "sg1" {
  name = "flipkart-vpc-sg1"
  vpc_id = module.vpc1.vpc_id
  # Allow Inbound rules
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["36.255.17.21/32"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Allow Outbound rules
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name       = "flipkart-sg1"
    Managed_by = "terraform"
  }
}
resource "aws_instance" "web1" {
  ami                         = "ami-0e86e20dae9224db8"
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc1.public_subnets[0]
  key_name                    = "AWS-Demo"
  associate_public_ip_address = "true"
  vpc_security_group_ids      = [aws_security_group.sg1.id]

  tags = {
    Name = "Web1"
  }
}
output "my_web1_public_ip" {
  value = aws_instance.web1.public_ip
}
output "my_web1_private_ip" {
  value = aws_instance.web1.private_ip
}
