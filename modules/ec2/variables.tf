#Create Multiple instances with their username and count
variable "instance_count" {
  type  = number
  default = 3
  description = "Number of EC2 instances"
}
variable "ec2_username" {
  type = string
  default = "ec2-user"
}
variable "key_name" {
  type = string
  default = "Terraform-prod-key"
}

variable "ec2_sg" {
  type = string
  default = "allow_ssh_prod"
  description = "Security group name"
}
variable "ssh_port" {
  type = number
  default = 22
}

variable "ami" {
  type = string
  default = "ami-0bdd88bd06d16ba03"
}
variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "tags" {
    type = map(string)
    default = {
      "Name" = "Terraform-EC2"
      "Environment" = "dev"
    }
}
variable "volume_size" {
  type = number
  default = 10
}
variable "volume_type" {
  type = string
  default = "gp3"
}

variable "environment" {
  type = string
  default = "dev"
}