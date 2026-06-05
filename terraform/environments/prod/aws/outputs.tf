output "ec2_master_ids" {
  description = "Ec2 Master Node ids"
  value       = module.aws_instance_config.master_ids
}

output "ec2_worker_ids" {
  description = "Ec2 Master Node ids"
  value       = module.aws_instance_config.worker_ids
}

output "dynamoDB_table_name" {
  value = module.aws_dynamodb_config.dynamodb_cart_table_name
}
