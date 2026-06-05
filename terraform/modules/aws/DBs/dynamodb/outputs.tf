output "dynamodb_cart_table_name" {
  description = "Use as CART_TABLE_NAME env var in Cart service"
  value       = aws_dynamodb_table.cart.name
}

output "dynamodb_cart_table_arn" {
  value = aws_dynamodb_table.cart.arn
}
