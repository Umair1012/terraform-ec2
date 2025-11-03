# Provider Configuration
provider "aws" {
  region = "us-east-1"
}

# Create Key Pair
resource "aws_key_pair" "default" {
  key_name   = "Terraform-key-first"
  public_key = file("~/.ssh/id_rsa.pub") # Change if needed
}

# Create a Security Group
resource "aws_security_group" "ec2_sg" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 Instance
resource "aws_instance" "ec2" {
  ami                    = "ami-0bdd88bd06d16ba03"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.default.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "My-First-Terraform-Instance"
  }
}

# Outputs
output "public_ip" {
  value = aws_instance.ec2.public_ip
}

output "public_dns" {
  value = aws_instance.ec2.public_dns
}

output "key_pair_used" {
  value = aws_key_pair.default.key_name
}
