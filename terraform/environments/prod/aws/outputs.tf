output "ec2_master_ids" {
  description = "Ec2 Master Node ids"
  value       = module.aws_instance_config.master_ids
}

output "ec2_worker_ids" {
  description = "Ec2 Master Node ids"
  value       = module.aws_instance_config.worker_ids
}

# App will Create DB
# output "dynamoDB_table_name" {
#   value = module.aws_dynamodb_config.dynamodb_cart_table_name
# }

output "order_sqs_url" {
  value = module.aws_sqs_config.sqs_url
}

output "rds_endpoint" {
  description = "Use as DB_HOST in Orders service"
  value       = module.aws_rds_postgress_config.rds_endpoint
}

output "rds_port" {
  value = module.aws_rds_postgress_config.rds_port
}

output "rds_db_name" {
  value     = module.aws_rds_postgress_config.rds_db_name
  sensitive = true
}
