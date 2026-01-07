provider "aws" {
    region = "us-east-1"
}

variable "env" {
    description = "The environment for the EC2 instance"
    type        = string
    default     = "dev"
}
variable "ec2-names" {
    description = "List of EC2 instance names"
    type        = list(string)
    default     = ["web1", "web2", "web3"]
}
# Loop to create multiple EC2 instances based on a list of names
# example -   for_each = toset(var.ec2-names)

resource "aws_instance" "web" {
    for_each                    = toset(var.ec2-names)
    ami                         = "ami-0ecb62995f68bb549"
    instance_type               = var.env == "prod" ? "t3.medium" : "t2.micro"
    key_name                    = "AWS-Demo"
    associate_public_ip_address = "true"
    vpc_security_group_ids      = ["default"]

    tags = {
        Name = "${each.key}-${var.env}"
        Environment = "${var.env}"
    }
}