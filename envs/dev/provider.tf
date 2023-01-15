locals {
  aws_profile = "gem-entertainment-standard-fa-dev_mfa"
}

provider "aws" {
  region = "ap-northeast-1"
  profile = local.aws_profile

  default_tags {
    tags = {
      Env    = "dev"
      System = "gem"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.2.0"

    }
  }
  required_version = "~> 1.3.1"
}
