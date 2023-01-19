module "god-api" {
  source      = "../ec2/instance/god-api"
  name        = "god-api"
  fqdn        = "god-api.${local.domain}"
  type        = var.god-api.type
  size        = var.god-api.size
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

module "alb-god-api" {
  source = "../alb"
  name   = "god-api"
  vpc_id = var.vpc.vpc_id
  acm    = var.acm.aws_acm_certificate_arn
  subnets = [
    for s in var.vpc.subnet_public : s.id
  ]

  security_group_ids = local.security_group_ids
  route53_zone_id    = var.route53.zone_id
  log_bucket         = module.s3-awslogs.bucket.bucket
  log_prefix         = "god-api"
  targets = [
    {
      name         = "god-api"
      priority     = 60
      instance_id  = module.god-api.god-api_id
      port         = 80
      health_check = "/health_check.txt"
      domain       = "dev.god-api.${local.domain}"
    }
  ]

  redirectors = [
  ]
}

resource "local_file" "rule" {
  filename        = "${path.cwd}/../etc/alb-god-api-rule.yaml"
  file_permission = "0755"
  content         = yamlencode(module.alb-god-api)
}
