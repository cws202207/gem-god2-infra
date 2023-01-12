data "terraform_remote_state" "vpc_main" {
  backend = "s3"

  config = {
    bucket = "gem-es-tfstate"
    key    = "${local.system_name}/${local.env_name}/vpc/main_v1.0.0.tfstate"
    region = "ap-northeast-1"
  }
}
