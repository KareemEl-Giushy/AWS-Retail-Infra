variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
  default     = "retail-store"
}

variable "private_route_table_id" {
  description = "Private route table ID for VPC endpoint association"
  type        = string
}

