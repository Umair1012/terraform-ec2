
variable "instance_count" {
  type  = number
  description = "Number of EC2 instances"
}
variable "ec2_username" {
  type = string
}
variable "key_name" {
  type = string
}

variable "ec2_sg" {
  type = string
  description = "Security group name"
}
variable "ssh_port" {
  type = number
}

variable "ami" {
  type = string
}
variable "instance_type" {
  type = string
}

variable "tags" {
    type = map(string)
}
variable "volume_size" {
  type = number
}
variable "volume_type" {
  type = string
}

variable "environment" {
  type = string
}