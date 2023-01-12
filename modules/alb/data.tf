data "terraform_remote_state" "log_alb" {
  backend = "s3"

  config = {
    bucket = "gem-es-tfstate"
    key    = "${local.system_name}/${local.env_name}/log/alb_v1.0.0.tfstate"
    region = "ap-northeast-1"
  }
}
