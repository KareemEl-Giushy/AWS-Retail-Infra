

# ── DynamoDB — Cart Service ───────────────────────────────────────────────────

resource "aws_dynamodb_table" "cart" {
  name         = "${DynamoDB1}-cart"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "userId"       # One cart per user

  attribute {
    name = "userId"
    type = "S"                  # S = String
  }

  # TTL: auto-delete abandoned carts after 30 days (saves cost)
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
    Project     = var.project_name
    Service     = "cart"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

# ── RDS PostgreSQL — Orders Service ──────────────────────────────────────────

resource "aws_db_subnet_group" "orders" {
  name       = "${var.project_name}-orders-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}

resource "aws_db_instance" "orders" {
  identifier        = "${var.project_name}-orders-db"
  engine            = "postgres"
  engine_version    = "15.4"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  db_name  = "orders"
  username = "dbadmin"
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.orders.name
  vpc_security_group_ids = var.db_security_group_ids
  publicly_accessible    = false       # NEVER expose DB to internet

  backup_retention_period = 7
  skip_final_snapshot     = true       # Set false in production!
  deletion_protection     = false      # Set true in production!

  tags = {
    Project     = var.project_name
    Service     = "orders"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}