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

variable "ec2_master_node_ami" {
  description = "Provide ami for Master Node"
  type        = string
}

variable "ec2_worker_node_ami" {
  description = "Provide ami for Wroker Node"
  type        = string
}

variable "az" {
  description = "Specify Availablity Zone"
  type        = string
  default     = "us-east-1a"
}
