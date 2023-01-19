#terraform {
#  cloud {
#    organization = "gem-entertainment-standard"
#    workspaces {
#      name = "gem-es2-fadev-vpc"
#    }
#  }
#}

terraform {
  backend "s3" {
    bucket = "gem-god-backend-fadev-vpc-tfstate"
    key    = "gem/fadev/vpc/main_v1.0.0.tfstate"
    region = "ap-northeast-1"
  }
}
