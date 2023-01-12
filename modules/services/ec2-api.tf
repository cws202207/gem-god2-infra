module "ec2-api2" {
  source      = "../ec2/instance/api2"
  name        = "api2"
  fqdn        = "api2.${local.domain}"
  type        = var.ec2-api2.type
  size        = var.ec2-api2.size
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

module "alb-api2" {
  source = "../alb"
  name   = "api2"
  vpc_id = var.vpc.vpc_id
  acm    = var.acm.aws_acm_certificate_arn
  subnets = [
    for s in var.vpc.subnet_public : s.id
  ]

  security_group_ids = local.security_group_ids
  route53_zone_id    = var.route53.zone_id
  log_bucket         = module.s3-awslogs.bucket.bucket
  log_prefix         = "api2"
  targets = [
    {
      name         = "api2"
      priority     = 60
      instance_id  = module.ec2-api2.api2_id
      port         = 80
      health_check = "/health_check.txt"
      domain       = "api2.${local.domain}"
    }
  ]

  redirectors = [
  ]
}

resource "local_file" "rule" {
  filename        = "${path.cwd}/../etc/alb-ec2-rule.yaml"
  file_permission = "0755"
  content         = yamlencode(module.alb-api2)
}

resource "local_file" "aws_alb" {
  filename        = "${path.cwd}/alb.sh"
  file_permission = "0755"
  content         = yamlencode(module.alb-api2)
}
