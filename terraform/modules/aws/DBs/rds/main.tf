resource "aws_db_subnet_group" "orders" {
  name       = "${var.project_name}-orders-subnet-group"
  subnet_ids = tolist(var.private_subnet_ids)   # ← Fixed: was private_subnet_id (singular)

  tags = {
    Project   = var.project_name
    ManagedBy = "Terraform"
  }
}                                               # ← Fixed: removed duplicate tags block

resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  description = "Allow PostgreSQL from inside VPC only"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

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

  db_name  = var.db_name       # ← Fixed: indentation was inconsistent
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.orders.name
  vpc_security_group_ids = [aws_security_group.rds.id]  # ← Fixed: was var.db_security_group_ids (removed)
  publicly_accessible    = false

  backup_retention_period = 7
  skip_final_snapshot     = true
  deletion_protection     = false

  tags = {
    Project     = var.project_name
    Service     = "orders"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}