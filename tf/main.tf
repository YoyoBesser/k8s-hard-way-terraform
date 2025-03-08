terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.90"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-southeast-2"
}


module "networking" {
  source = "./networking"
}

module "compute" {
  source = "./compute"
  depends_on = [ module.networking ]
  vpc_id = module.networking.vpc_id
  public_subnet_id = module.networking.public_subnet_id
  private_subnet_id = module.networking.private_subnet_id
  ssh_access_sg_id = module.networking.ssh_access_sg_id
  internet_egress_sg_id = module.networking.internet_egress_sg_id
}
