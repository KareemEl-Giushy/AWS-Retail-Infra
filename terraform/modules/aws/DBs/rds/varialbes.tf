variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
  default     = "aws-retail"
}

variable "db_password" {
  description = "Password for RDS PostgreSQL"
  type        = string
  sensitive   = true
  ephemeral   = true
}

variable "private_subnet_id" {
  description = "Private subnet ID for RDS (must be in a private AZ)"
  type        = string

  validation {
    condition     = length(var.private_subnet_id) > 0
    error_message = "You must provide a valid private subnet ID."
  }
}

variable "az" {
  description = "Another az for the subnet"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where RDS lives"
  type        = string
}

variable "db_name" {
  description = "Name of the PostgreSQL database"
  type        = string
  default     = "orders"
}

variable "db_username" {
  description = "Master username for RDS"
  type        = string
  default     = "dbadmin"
}
