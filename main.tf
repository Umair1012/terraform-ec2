

# Create Key Pair
resource "aws_key_pair" "default" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub") # Change if needed
}

# Create a Security Group
resource "aws_security_group" "ec2_sg" {
  name        = var.ec2_sg
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = var.ssh_port
    to_port     = var.ssh_port
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
  ami                    = var.ami  #Amazon Linux
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  count = var.instance_count
  tags = {
    Name = "${var.tags["Name"]}-${count.index}"
  }
  root_block_device {
    volume_size = var.volume_size
    volume_type = var.volume_type
  }
}

