resource "aws_dynamodb_table" "cart" {
  name         = "${var.project_name}-cart"
  billing_mode = "PAY_PER_REQUEST"

  hash_key = "itemID"

  attribute {
    name = "itemID"
    type = "S"
  }

  ttl {
    attribute_name = "expiresAt"
    enabled        = true
  }

  server_side_encryption {
    enabled = true
  }

  tags = {
    Project   = var.project_name
    Service   = "cart"
    ManagedBy = "Terraform"
  }
}
