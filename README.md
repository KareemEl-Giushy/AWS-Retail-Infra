# AWS-Retail-Store Sample Infra IaC Definition

### Project Used:

[aws-containers/retail-store-sample-app](https://github.com/aws-containers/retail-store-sample-app)




### resources:


[Ansible Inventory](https://docs.ansible.com/projects/ansible/latest/collections/amazon/aws/aws_ec2_inventory.html#examples)

[kubeadm Install](https://dev.to/aws-builders/create-basic-cluster-with-kubeadm-on-aws-ec2-instance-2l1p)

[SSM Manager on Ec2](https://docs.aws.amazon.com/systems-manager/latest/userguide/ssm-agent.html)


this in `~/.ssh/config` file
```bash
host i-* mi-*
    # User Ubuntu
    IdentityFile ~/.ssh/your-ec2-key.pem
    ProxyCommand sh -c "aws ssm start-session --target %h --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
    StrictHostKeyChecking no
    UserKnownHostsFile /dev/null
```

[Create a Custom Image With Packer on AWS](https://dev.to/aws-builders/creating-a-custom-amazon-machine-image-ami-with-hashicorp-packer-on-aws-2ig2)



Ec2->ssm->ssh->localhost
```bash
ssh -N -L 6443:127.0.0.1:6443 ubuntu@<INSTANCE_ID>
```