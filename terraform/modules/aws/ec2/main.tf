locals {
  ubuntu_image = "ami-091138d0f0d41ff90"
}

data "aws_subnet" "selected" {
  id = var.ec2_subnet_id
}

resource "aws_key_pair" "deployer" {
  key_name   = "ec2-key"
  public_key = var.ec2_ssh_key
}

resource "aws_security_group" "ec2_sg" {
  vpc_id      = data.aws_subnet.selected.vpc_id
  name        = "Ec2 Private Sg"
  description = "Security Group to be assigned to Private EC2"
}

resource "aws_instance" "master_node" {
  ami           = local.ubuntu_image
  instance_type = "t3.small"

  key_name  = aws_key_pair.deployer.key_name
  subnet_id = var.ec2_subnet_id

  user_data = var.ec2_init_script

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  root_block_device {
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "gp3"
  }

  tags = {
    Name = "Master-Node"
    Env  = "k8s"
  }
}

resource "aws_instance" "worker_node" {
  ami           = local.ubuntu_image
  instance_type = "t3.micro"

  key_name  = aws_key_pair.deployer.key_name
  subnet_id = var.ec2_subnet_id

  user_data = var.ec2_init_script

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  root_block_device {
    delete_on_termination = true
    volume_size           = 20
    volume_type           = "gp3"
  }

  tags = {
    Name = "Worker-Node"
    Env  = "k8s"
  }
}
