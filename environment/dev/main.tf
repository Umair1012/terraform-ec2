# Generate an RSA private key (like ssh-keygen -t rsa -b 4096)
resource "tls_private_key" "generated" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

#Create key pair
resource "aws_key_pair" "default" {
  key_name   = var.key_name
  public_key = tls_private_key.generated.public_key_openssh # Change if needed
}

# Save private key locally
resource "local_file" "private_key" { 
content = tls_private_key.generated.private_key_pem 
filename = "private_key_${var.environment}.pem" 
file_permission = "0400"  # Restrict access to the private key
}


#Call EC2 module
module "dev_ec2" {
  source = "../../modules/ec2"
  environment = "dev"
  ami = "ami-0cae6d6fe6048ca2c"
  instance_count = 2
  ec2_username = "ubuntu"
  key_name = aws_key_pair.default.key_name
  ec2_sg = "dev-${var.environment}"
  ssh_port = 80
  tags = {
    Name = "Dev-${var.environment}"
    Environment = "dev"
  }
  volume_size = 10
  volume_type = "gp3"
  instance_type = "t2.micro"
  user_data = "file('${path.module}/scripts/install_services.sh')"
} 

