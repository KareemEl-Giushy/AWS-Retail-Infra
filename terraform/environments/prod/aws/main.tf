locals {
  app_secrets = templatefile("${path.module}/secret.tftpl", {
    ACCESS_KEY_ID     = ephemeral.aws_ssm_parameter.access_key_id.value
    SECRET_ACCESS_KEY = ephemeral.aws_ssm_parameter.access_key_secret.value
  })
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

  db_name     = data.aws_ssm_parameter.dbname.value
  db_username = data.aws_ssm_parameter.dbusername.value
  db_password = ephemeral.aws_ssm_parameter.rds_db_password.value

  az = data.aws_availability_zones.available.names[1]
}

resource "null_resource" "save_config" {
  triggers = {
    run_id = uuid()
  }

  provisioner "local-exec" {
    command = "echo '${local.app_secrets}' > ../../../../k8s/secret.yaml"
  }
}
