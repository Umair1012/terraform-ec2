#Create key pair
resource "aws_key_pair" "default" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_rsa.pub") # Change if needed
}

#Call EC2 module
module "dev_ec2" {
  source = "../../modules/ec2"
  environment = var.environment
  ami = var.ami
  count = var.instance_count
  ec2_username = var.ec2_username
  key_name = var.key_name
  ec2_sg = var.ec2_sg
  ssh_port = var.ssh_port
  tags = {
    Name = "${var.tags["Name"]}-${count.index+1}"
    Environment = var.environment
  }
  volume_size = var.volume_size
  volume_type = var.volume_type
  instance_type = var.instance_type






} 