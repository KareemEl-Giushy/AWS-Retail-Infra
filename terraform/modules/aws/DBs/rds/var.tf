variable "project_name" {
  description = "Name prefix for all resources"
  type        = string
  default     = "retail-store"
}

variable "environment" {
  description = "dev or prod"
  type        = string
  default     = "dev"
}

variable "db_password" {
  description = "Password for RDS PostgreSQL"
  type        = string
  sensitive   = true
}

variable "private_subnet_ids" {              # ← Fixed: was singular private_subnet_id
  description = "List of private subnet IDs"
  type        = list(string)                 # ← Fixed: was string, must be list
  validation {
    condition     = length(var.private_subnet_ids) >= 2
    error_message = "RDS requires at least 2 subnets in different AZs."
  }
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