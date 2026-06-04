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

variable "private_subnet_ids" {
  description = "List of private subnet IDs for RDS"
  type        = list(string)
}

