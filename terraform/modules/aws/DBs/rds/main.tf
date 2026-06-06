data "aws_vpc" "main" {
  id = var.vpc_id
}

resource "aws_subnet" "dummy_placeholder" {
  vpc_id            = data.aws_vpc.main.id
  cidr_block        = "10.0.0.144/28"
  availability_zone = var.az
  tags              = { Name = "RDS-Dummy-Subnet" }
}

resource "aws_db_subnet_group" "orders" {
  name       = "${var.project_name}-orders-subnet-group"
  subnet_ids = [var.private_subnet_id, aws_subnet.dummy_placeholder.id]

  tags = {
    app = "aws-retail"
  }
}


resource "aws_security_group" "rds" {
  name        = "${var.project_name}-rds-sg"
  description = "Allow PostgreSQL from inside VPC only"
  vpc_id      = data.aws_vpc.main.id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    app = "aws-retail"
  }
}

resource "aws_db_instance" "orders" {
  identifier        = "${var.project_name}-orders-db"
  engine            = "postgres"
  engine_version    = "16.6"
  instance_class    = "db.t3.micro"
  availability_zone = "us-east-1a"
  allocated_storage = 5
  multi_az          = false

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.orders.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false

  skip_final_snapshot = true
  deletion_protection = false

  tags = {
    Service = "orders"
    app     = "aws-retail"
  }
}
