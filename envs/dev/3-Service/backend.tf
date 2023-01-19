#terraform {
#  cloud {
#    organization = "gem-entertainment-standard"
#    workspaces {
#      name = "gem-es2-fadev-services"
#    }
#  }
#}

terraform {
  backend "s3" {
    bucket = "gem-god-backend-fadev-services-tfstate"
    key    = "gem/fadev/services/main_v1.0.0.tfstate"
    region = "ap-northeast-1"
  }
}
