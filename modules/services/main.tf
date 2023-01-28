variable "aws_type" {}
variable "key_name" {}
variable "vpc" {}
variable "route53" {}
variable "aws_profile" {}
variable "aurora-mysql" {}
variable "acm" {}
variable "god-api" {}
#variable "ec2-crawler" {}
variable "ec2-mgmt" {}
variable "god-hand" {}

locals {
  domain            = var.route53.name
  local_domain      = format("%s.aws", local.domain)
  host-ssh-god-api  = "dev.god-api.${var.aws_type}"
  host-ssh-crawler  = "dev.crawler.${var.aws_type}"
  host-ssh-mgmt     = "dev.mgmt.${var.aws_type}"
  host-ssh-god-hand = "dev.god-hand.${var.aws_type}"
  appconfig         = "${path.cwd}/../../../appconfig/${var.aws_type}"
#  source            = "${path.cwd}/../../../source"
}
