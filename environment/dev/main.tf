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
module "frontend_ec2" {
  source = "../../modules/ec2"
  environment = "dev"
  ami = "ami-0ecb62995f68bb549"
  instance_count = 1
  ec2_username = "ubuntu"
  key_name = aws_key_pair.default.key_name
  ec2_sg = "frontend-${var.environment}"
  ssh_port = 22
  tags = {
    Name = "Frontend-${var.environment}"
    Environment = "dev"
  }
  volume_size = 10
  volume_type = "gp3"
  instance_type = "t2.micro"
} 

module "backend_ec2" {
  source = "../../modules/ec2"
  environment = "dev"
  ami = "ami-0ecb62995f68bb549"
  instance_count = 1
  ec2_username = "ubuntu"
  key_name = aws_key_pair.default.key_name
  ec2_sg = "backend-${var.environment}"
  ssh_port = 22
  tags = {
    Name = "Backend-${var.environment}"
    Environment = "dev"
  }
  volume_size = 15
  volume_type = "gp3"
  instance_type = "t2.micro"
} 

module "database_ec2" {
  source = "../../modules/ec2"
  environment = "dev"
  ami = "ami-0ecb62995f68bb549"
  instance_count = 2
  ec2_username = "ubuntu"
  key_name = aws_key_pair.default.key_name
  ec2_sg = "database-${var.environment}"
  ssh_port = 22
  tags = {
    Name = "Database-${var.environment}"
    Environment = "dev"
  }
  volume_size = 20
  volume_type = "gp3"
  instance_type = "t2.micro"
} 