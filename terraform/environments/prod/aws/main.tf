data "aws_s3_bucket" "terraform-backend" {
  bucket = "terraform-state-294936105594-us-east-1-an"
}


module "aws_vpc_config" {
  source = "../../../modules/aws/vpc"
  providers = {
    aws = aws
  }
}


module "aws_instance_config" {
  source          = "../../../modules/aws/ec2"
  ec2_subnet_id   = module.aws_vpc_config.private_subnet_id
  ec2_ssh_key     = file("../../../../keys/ec2-key.pub")
  ec2_init_script = file("../../../../scripts/ec2_init.sh")
  providers = {
    aws = aws
  }
  depends_on = [module.aws_vpc_config]
}
