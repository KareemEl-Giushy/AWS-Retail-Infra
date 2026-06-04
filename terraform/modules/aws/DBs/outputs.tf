output "dynamodb_cart_table_name" {
  description = "DynamoDB table name — use as CART_TABLE_NAME env var in Cart service"
  value       = aws_dynamodb_table.cart.name
}

output "dynamodb_cart_table_arn" {
  value = aws_dynamodb_table.cart.arn
}

output "rds_endpoint" {
  description = "RDS host — use as DB_HOST env var in Orders service"
  value       = aws_db_instance.orders.address
}

output "rds_port" {
  value = aws_db_instance.orders.port
}

output "rds_db_name" {
  value = aws_db_instance.orders.db_name
}