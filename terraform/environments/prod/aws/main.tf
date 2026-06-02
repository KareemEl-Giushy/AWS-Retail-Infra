data "aws_s3_bucket" "terraform-backend" {
  bucket = "terraform-state-294936105594-us-east-1-an"
}


module "aws_vpc_config" {
  source = "../../../modules/aws/vpc"
  providers = {
    aws = aws
  }
}
