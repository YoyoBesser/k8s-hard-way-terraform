##### find latest amazon linux 2023 ami

data "aws_ami" "latest-al2023-ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "architecture"
    values = ["x86_64"] # Changed from "arm64" to "x86_64"
  }

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}





### Machines
resource "aws_instance" "jumpbox" {
  ami                         = data.aws_ami.latest-al2023-ami.id
  instance_type               = "t2.micro"
  subnet_id                   = var.public_subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.ssh_access_sg_id, var.internet_egress_sg_id]
  key_name                    = aws_key_pair.generated_key.key_name

  root_block_device {
    volume_size = 10
  }

  tags = {
    project = "k8s-hard-way"
    role    = "jumpbox"
    Name    = "jumpbox"
  }

}

resource "aws_instance" "server" {
  ami                    = data.aws_ami.latest-al2023-ami.id
  instance_type          = "t2.micro"
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.internet_egress_sg_id]
  key_name               = aws_key_pair.generated_key.key_name

  root_block_device {
    volume_size = 20
  }

  tags = {
    project = "k8s-hard-way"
    role    = "server"
    Name    = "server"
  }
}

resource "aws_instance" "node-0" {
  ami                    = data.aws_ami.latest-al2023-ami.id
  instance_type          = "t2.micro"
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.internet_egress_sg_id]
  key_name               = aws_key_pair.generated_key.key_name
  root_block_device {
    volume_size = 20
  }

  tags = {
    project = "k8s-hard-way"
    role    = "node-0"
    Name    = "node-0"
  }
}

resource "aws_instance" "node-1" {
  ami                    = data.aws_ami.latest-al2023-ami.id
  instance_type          = "t2.micro"
  subnet_id              = var.private_subnet_id
  vpc_security_group_ids = [var.internet_egress_sg_id]
  key_name               = aws_key_pair.generated_key.key_name

  root_block_device {
    volume_size = 20
  }

  tags = {
    project = "k8s-hard-way"
    role    = "node-1"
    Name    = "node-1"
  }
}


#### SSH Key for accessing machines

resource "tls_private_key" "ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "k8s-hard-way-ssh-key"
  public_key = tls_private_key.ssh_key.public_key_openssh

  tags = {
    project = "k8s-hard-way"
  }
}


