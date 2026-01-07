provider "aws" {
    region = "us-east-1"
}

variable "env" {
    description = "The environment for the EC2 instance"
    type        = string
    default     = "dev"
}

# conditional EC2 instance based on environment  
# example -   "condition" ? "if-true" : "if-false"

resource "aws_instance" "web1" {
    ami                         = "ami-0ecb62995f68bb549"
    instance_type               = var.env == "prod" ? "t3.medium" : "t2.micro"
    key_name                    = "AWS-Demo"
    associate_public_ip_address = "true"
    vpc_security_group_ids      = ["default"]

    tags = {
        Name = "Web1-${var.env}"
        Environment = "${var.env}"
    }
}
output "web1-instance-type" {
    value = aws_instance.web1.instance_type
}