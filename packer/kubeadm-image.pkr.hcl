packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.8.1"
    }
    vagrant = {
      version = ">= 1.1.6"
      source  = "github.com/hashicorp/vagrant"
    }
  }
}


source "amazon-ebs" "kubeadm-image" {
  ami_name      = "${var.ami_prefix}-kubeadm-${var.node_role}"
  instance_type = "t3.small"
  region        = "us-east-1"
  ssh_username  = "ubuntu"
  source_ami    = var.ami_base_image
}


build {
  name = "ami-kubeadm"

  sources = ["source.amazon-ebs.kubeadm-image"]

  provisioner "shell" {
    scripts = ["../scripts/install_kubeadm.sh"]

    environment_vars = [
        "ROLE=${var.node_role}"
    ]
  }

#   post-processor "vagrant" {}

}