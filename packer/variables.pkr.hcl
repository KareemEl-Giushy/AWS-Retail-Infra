variable "ami_prefix" {
  description = "Add Perfix to Custom Image"
  type        = string
  default     = "v0.1"
}

variable "ami_base_image" {
  description = "Image to be used to install Kubeadm"
  type        = string
  default     = "ami-091138d0f0d41ff90"
}

variable "node_role" {
  description = "Node role in the cluster"
  type        = string
  default     = "worker"
}