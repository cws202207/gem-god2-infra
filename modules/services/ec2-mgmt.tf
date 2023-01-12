module "ec2-mgmt" {
  source      = "../ec2/instance/mgmt"
  name        = "mgmt"
  fqdn        = "mgmt.${local.domain}"
  type        = var.ec2-mgmt.type
  size        = var.ec2-mgmt.size
  ami         = local.ami
  key_name    = var.key_name
  subnet_id   = var.vpc.aws_subnet_private_a_id
  profile     = "StandardInstanceProfile"
  aws_profile = var.aws_profile
  security_groups = [
    local.security_group_ids.private,
  ]
}

