locals {
  route53 = yamldecode(file("${path.cwd}/../etc/tf-route53.yaml"))
  vpc     = yamldecode(file("${path.cwd}/../etc/tf-vpc.yaml"))
  acm     = yamldecode(file("${path.cwd}/../etc/tf-acm.yaml"))
}

# ----------------------------
# service
# ----------------------------
module "services" {
  source              = "../../../modules/services"
  aws_type            = "fadev"
  key_name            = "sou@gem-ed25519-20221205_company_mac"
  vpc                 = local.vpc
  route53             = local.route53
  aws_profile         = local.aws_profile # 多要素認証は無効　あとで
  route_table_private = local.vpc.route_table_private
  acm                 = local.acm
  aurora-mysql = {
    production = false
    class      = "db.t4g.medium"
  }
  ec2-api2 = {
    type = "t3a.small"
    size = 32
  }
  ec2-crawler = {
    type = "t3a.small"
    size = 32
  }
  ec2-mgmt = {
    type = "t3a.small"
    size = 32
  }
  ec2-unity = {
    type = "t3a.small"
    size = 32
  }
}

output "callers" {
	value = module.services.caller
}

output "profile1" {
	value = local.aws_profile
}

output "alb" {
	value = module.services.albb
}
