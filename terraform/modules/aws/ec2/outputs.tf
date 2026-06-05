output "master_ids" {
  value = [aws_instance.master_node.id]
}

output "worker_ids" {
  value = [aws_instance.worker_node.id]
}
