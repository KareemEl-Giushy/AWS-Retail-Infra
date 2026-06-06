output "rds_endpoint" {
  description = "Use as DB_HOST in Orders service"
  value       = aws_db_instance.orders.address
}

output "rds_port" {
  value = aws_db_instance.orders.port
}

output "rds_db_name" {
  value = aws_db_instance.orders.db_name
}
