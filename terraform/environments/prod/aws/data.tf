data "aws_s3_bucket" "terraform-backend" {
  bucket = "terraform-state-294936105594-us-east-1-an"
}

data "aws_ami" "master_node_ami" {
  owners      = ["self"]
  most_recent = true
  filter {
    name   = "name"
    values = ["*-kubeadm-master"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "aws_ami" "worker_node_ami" {
  owners      = ["self"]
  most_recent = true
  filter {
    name   = "name"
    values = ["*-kubeadm-worker"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

ephemeral "aws_ssm_parameter" "access_key_id" {
  arn = "arn:aws:ssm:us-east-1:294936105594:parameter/ACCESS_KEY_ID"
}

ephemeral "aws_ssm_parameter" "access_key_secret" {
  arn = "arn:aws:ssm:us-east-1:294936105594:parameter/SECRET_ACCESS_KEY"
}

ephemeral "aws_ssm_parameter" "rds_db_password" {
  arn = "arn:aws:ssm:us-east-1:294936105594:parameter/rds_db_password"
}

data "aws_ssm_parameter" "dbname" {
  name = "postgress_rds_dbname"
}

data "aws_ssm_parameter" "dbusername" {
  name = "postgres_rds_username"
}

data "aws_ssm_parameter" "dbpassword" {
  name = "rds_db_password"
}
