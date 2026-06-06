# Get current account ID automatically
data "aws_caller_identity" "current" {}

resource "aws_sqs_queue" "order_sqs" {
  name = "aws-retail-order_sqs.fifo"
  # name_prefix               = "aws-retail"
  fifo_queue                = true
  delay_seconds             = 0
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 10
  sqs_managed_sse_enabled   = true

  tags = {
    app = "aws-retail-aws"
  }
}

