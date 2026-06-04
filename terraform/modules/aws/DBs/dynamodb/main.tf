resource "aws_dynamodb_table" "cart" {
  name         = "${var.project_name}-cart"   # ← Fixed: was ${DynamoDB1} which is wrong
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "userId"

  attribute {
    name = "userId"
    type = "S"
  }

  ttl {
    attribute_name = "expiresAt"
    enabled        = true
  }

  point_in_time_recovery {
    enabled = true
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