# ------------------------------------------------------------
# Variables for AWS ↔ Azure Site-to-Site VPN
# ------------------------------------------------------------

variable "azure_vpn_gateway_ip" {
  description = "Public IP of the Azure VPN Gateway (from Task 1 output)"
  type        = string
}

variable "azure_network_cidr" {
  description = "Azure VNet address space e.g. 10.0.0.0/16"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpn_shared_key" {
  description = "Pre-shared key — must match Azure Task 1"
  type        = string
  sensitive   = true
}

variable "aws_network_cidr" {
  description = "AWS VPC address space e.g. 10.0.0.0/16"
  type        = string
  default     = "10.0.0.0/16"
}

variable "project_name" {
  description = "Project name used for tagging AWS resources"
  type        = string
  default     = "demo-internal"
}

