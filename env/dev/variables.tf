##General Config
variable "general_config" {
  type = map(any)
  default = {
    project = "example"
    env     = "dev"
  }
}

##Regions
variable "regions" {
  default = {
    tokyo    = "ap-northeast-1"
    virginia = "us-east-1"
  }
}

##Network
variable "vpc" {
  description = "CIDR BLOCK for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "availability_zones" {
  type = map(any)
  default = {
    availability_zones = {
      az-1a = {
        az = "ap-northeast-1a"
      },
      az-1c = {
        az = "ap-northeast-1c"
      }
    }
  }
}

variable "public_subnets" {
  type = map(any)
  default = {
    subnets = {
      public-1a = {
        name = "public-1a",
        cidr = "10.0.10.0/24",
        az   = "ap-northeast-1a"
      },
      public-1c = {
        name = "public-1c",
        cidr = "10.0.30.0/24",
        az   = "ap-northeast-1c"
      }
    }
  }
}

variable "private_subnets" {
  type = map(any)
  default = {
    subnets = {
      private-1a = {
        name = "private-1a"
        cidr = "10.0.20.0/24"
        az   = "ap-northeast-1a"
      },
      private-1c = {
        name = "private-1c"
        cidr = "10.0.40.0/24"
        az   = "ap-northeast-1c"
      }
    }
  }
}

##EC2
variable "instance_role" {
  description = "role of instance"
}

variable "ami" {
  description = "ID of AMI to use for ec2 instance"
  default     = "ami-0bba69335379e17f8"
}

variable "instance_type" {
  description = "The type of instance"
  type        = string
  default     = "t3.micro"
}

variable "volume_type" {
  description = "The type of root block device"
  type        = string
  default     = "gp2"
}

variable "volume_size" {
  description = "The size of root block device"
  default     = 100
}

variable "key_name" {
  description = "key name of the key pair"
  type        = string
  default     = "example"
}

##Route53 Zone 
#variable "zone_name" {
#  description = "zone name of route53"
#  type        = string
#  default     = "shiratest.net"
#}

##Route53 Records
variable "sub_domain_1" {
  description = "name of sub domain"
  type        = string
  default     = "www"
}

variable "sub_domain_2" {
  description = "name of sub domain"
  type        = string
  default     = "loadbalancer"
}

##RDS Option Group
variable "engine_name" {
  type    = string
  default = "mysql"
}

variable "major_engine_version" {
  type    = string
  default = "8.0"
}

##RDS
variable "engine" {
  type    = string
  default = "mysql"
}

variable "engine_version" {
  type    = string
  default = "8.0"
}

variable "username" {
  description = "root username of db instance"
  type        = string
  default     = "admin"
}

variable "password" {
  description = "root password of db instance"
  type        = string
  default     = "Password1!"
}

variable "instance_class" {
  description = "The class of db instance"
  type        = string
  default     = "db.t3.medium"
}

variable "storage_type" {
  description = "The storage type of db instance"
  type        = string
  default     = "gp2"
}

variable "allocated_storage" {
  description = "The allocated storage of db instance"
  default     = 20
}

variable "multi_az" {
  description = "multi az of db instance"
  type        = string
  default     = "true"
}

##SNS email address
variable "sns_email" {
  description = "sns email"
}

##Cloud Watch Alearm Actions
variable "cwa_actions" {
  description = "Cloud watch alearm actions"
  type        = string
  default     = "false"
}

##Cloud Watch Threshold
variable "cwa_threshold_rds_freeablememory" {
  description = "threshold of freeable memory on rds"
  type        = number
  #3.3GB
  default = 3543348019
}

variable "cwa_threshold_rds_freeablestorage" {
  description = "threshold of freeable storage on rds"
  type        = number
  #17GB
  default = 18253611008
}