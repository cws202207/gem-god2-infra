provider "aws" {
  region = "ap-northeast-1"

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
