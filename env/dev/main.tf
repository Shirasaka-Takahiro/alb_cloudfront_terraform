provider "aws" {
  profile = "terraform-user"
  region  = var.regions["tokyo"]
}

provider "aws" {
  profile = "terraform-user"
  alias  = "us-east-1"
  region = var.regions["virginia"]
}

terraform {
  required_version = "~> 1.3.6"
  backend "s3" {
    bucket  = "example-dev-tfstate-bucket"
    region  = "ap-northeast-1"
    key     = "dev.tfstate"
    profile = "terraform-user"
  }
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.49.0"
    }
  }
}

module "dev" {
  source = "../../"

  general_config     = var.general_config
  regions            = var.regions
  availability_zones = var.availability_zones
  vpc_cidr           = var.vpc_cidr
  public_subnets     = var.public_subnets
  private_subnets    = var.private_subnets
  public_subnet_ids  = module.dev.public_subnet_ids
  private_subnet_ids = module.dev.private_subnet_ids
  ami                = var.ami
  key_name           = var.key_name
  instance_role      = var.instance_role
  instance_type      = var.instance_type
  volume_type        = var.volume_type
  volume_size        = var.volume_size
  instance_ids       = module.dev.instance_ids
  #zone_name          = var.zone_name
  sub_domain_1                      = var.sub_domain_1
  sub_domain_2                      = var.sub_domain_2
  engine_name                       = var.engine_name
  major_engine_version              = var.major_engine_version
  engine                            = var.engine
  engine_version                    = var.engine_version
  username                          = var.username
  password                          = var.password
  instance_class                    = var.instance_class
  storage_type                      = var.storage_type
  allocated_storage                 = var.allocated_storage
  multi_az                          = var.multi_az
  sns_email                         = var.sns_email
  cwa_actions                       = var.cwa_actions
  cwa_threshold_rds_freeablememory  = var.cwa_threshold_rds_freeablememory
  cwa_threshold_rds_freeablestorage = var.cwa_threshold_rds_freeablestorage
}