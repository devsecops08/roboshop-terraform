resource "aws_instance" "instance" {
  ami           = "ami-09c813fb71547fc4f"
  instance_type = "t3.small"
  vpc_security_group_ids = ["sg-049f3b7cfdfab115b"]
  tags = {
    Name = "test-${var.env}"
  }
}

variable "env" {}