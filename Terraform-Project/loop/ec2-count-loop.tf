provider "aws" {
    region = "us-east-1"
}

variable "env" {
    description = "The environment for the EC2 instance"
    type        = string
    default     = "dev"
}
# Loop to create multiple EC2 instances based on a count
# example -   count = 3
resource "aws_instance" "web" {
    count = 2
    ami                         = "ami-0ecb62995f68bb549"
    instance_type               = var.env == "prod" ? "t3.medium" : "t2.micro"
    key_name                    = "AWS-Demo"
    associate_public_ip_address = "true"
    vpc_security_group_ids      = ["default"]

    tags = {
        Name = "${var.env}-${count.index}"
        #  count.index + 1 can be used if you want to start from 1 instead of 0
        Environment = "${var.env}"
    }
}
# Built-in Functions can be used to get more details about the created resources
# For example, using length() to get the number of instances created
# Name = upper("${var.env}-${count.index}")