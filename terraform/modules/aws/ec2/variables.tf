variable "ec2_subnet_id" {
  description = "The Subnet to attach the Network Interface to Subnet"
  type        = string
}

variable "ec2_ssh_key" {
  description = "SSH key Used to Configure EC2"
  type        = string
}

variable "ec2_init_script" {
  description = "Script to run After Creating the EC2"
  type        = string
}
