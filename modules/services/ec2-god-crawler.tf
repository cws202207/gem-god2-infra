module "god-crawler" {
  source      = "../ec2/instance/god-crawler"
  name        = "god-crawler"
  fqdn        = "god-crawler.${local.domain}"
  type        = var.god-crawler.type
  size        = var.god-crawler.size
  ami         = local.ami
  key_name    = var.key_name
  subnet_id   = var.vpc.aws_subnet_private_a_id
  profile     = "StandardInstanceProfile"
  aws_profile = var.aws_profile
  security_groups = [
    local.security_group_ids.private,
    local.security_group_ids.alb-ec2,
  ]
}

