resource "aws_security_group" "sg" {
  name        = "${var.component_name}-${var.env}-sg"
  description = "inbound allow for ${var.component_name}"
  

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"] 
  }

  ingress {
    from_port        = var.app_port
    to_port          = var.app_port
    protocol         = "TCP"
    cidr_blocks      = ["0.0.0.0/0"]  
  }

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
}

resource "aws_instance" "instance" {
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  tags = {
    Name = " ${var.component_name}-${var.env}"
  }


provisioner  "local-exec" {
  command = <<EDL

  cd /home/ec2-user/roboshop-ansible
  "ansile-playbook -i ${self.private_ip}, -e ansible_user=ec2_user -e ansible_password=DevOPS321 -e app_name=${var.component_name} -e env=${var.env}main.yml"
  EDL

  }
}