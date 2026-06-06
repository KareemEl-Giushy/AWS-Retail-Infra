variable "postgress_db_name" {
  description = "Database name for postgress RDS"
  type        = string
}

variable "postgres_username" {
  description = "Database username for postgress RDS"
  type        = string
}
variable "postgres_password" {
  description = "Database password for postgress RDS"
  type        = string
  sensitive   = true
}
