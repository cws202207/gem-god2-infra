module "god-hand" {
  source      = "../ec2/instance/god-hand"
  name        = "god-hand"
  fqdn        = "god-hand.${local.domain}"
  type        = var.god-hand.type
  size        = var.god-hand.size
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

module "alb-god-hand" {
  source = "../alb/god-hand"
  name   = "god-hand"
  vpc_id = var.vpc.vpc_id
  acm    = var.acm.aws_acm_certificate_arn
  subnets = [
    for s in var.vpc.subnet_public : s.id
  ]

  security_group_ids = local.security_group_ids
  route53_zone_id    = var.route53.zone_id
  log_bucket         = module.s3-awslogs.bucket.bucket
  log_prefix         = "god-hand"
  targets = [
    {
      name         = "god-hand"
      priority     = 60
      instance_id  = module.god-hand.god-hand_id
      port         = 80
      health_check = "/health_check.txt"
      domain       = "dev.god-hand.${local.domain}"
    }
  ]

  redirectors = [
  ]
}

