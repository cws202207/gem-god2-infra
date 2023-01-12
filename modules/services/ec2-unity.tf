module "ec2-unity" {
  source      = "../ec2/instance/unity"
  name        = "unity"
  fqdn        = "unity.${local.domain}"
  type        = var.ec2-unity.type
  size        = var.ec2-unity.size
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
