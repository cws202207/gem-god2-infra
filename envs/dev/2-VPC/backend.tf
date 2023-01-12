#terraform {
#  cloud {
#    organization = "gem-entertainment-standard"
#    workspaces {
#      name = "gem-dev-infra-network-main"
#    }
#  }
#}

terraform {
  backend "s3" {
    bucket = "gem-es-tfstate"
    key    = "gem/dev/vpc/main_v1.0.0.tfstate"
    region = "ap-northeast-1"
  }
}
