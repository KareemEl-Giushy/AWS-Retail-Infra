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

module "aws_vpc_config" {
  source = "../../../modules/aws/vpc"
  az     = data.aws_availability_zones.available.names
  providers = {
    aws = aws
  }
}


module "aws_instance_config" {
  source              = "../../../modules/aws/ec2"
  az                  = data.aws_availability_zones.available.names[0]
  ec2_subnet_id       = module.aws_vpc_config.private_subnet_id
  ec2_ssh_key         = file("../../../../keys/ec2-key.pub")
  ec2_init_script     = file("../../../../scripts/ec2_init.sh")
  ec2_master_node_ami = data.aws_ami.master_node_ami.id
  ec2_worker_node_ami = data.aws_ami.worker_node_ami.id
  providers = {
    aws = aws
  }
  depends_on = [module.aws_vpc_config]
}

# Don't need it as it will be created by the micro-service
# module "aws_dynamodb_config" {
#   source = "../../../modules/aws/DBs/dynamodb"
# }

module "aws_sqs_config" {
  source = "../../../modules/aws/sqs"
  vpc_id = module.aws_vpc_config.vpc_id
}

module "aws_rds_postgress_config" {
  source            = "../../../modules/aws/DBs/rds"
  vpc_id            = module.aws_vpc_config.vpc_id
  private_subnet_id = module.aws_vpc_config.private_subnet_id
  db_name           = var.postgress_db_name
  db_username       = var.postgres_username
  db_password       = var.postgres_password
  az                = data.aws_availability_zones.available.names[1]
}
