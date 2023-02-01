module "god-batch" {
  source      = "../ec2/instance/god-batch"
  name        = "god-batch"
  fqdn        = "god-batch.${local.domain}"
  type        = var.god-batch.type
  size        = var.god-batch.size
  ami         = local.ami
  key_name    = var.key_name
  subnet_id   = var.vpc.aws_subnet_private_a_id
  profile     = "StandardInstanceProfile"
  aws_profile = var.aws_profile
  security_groups = [local.security_group_ids.private]
}
