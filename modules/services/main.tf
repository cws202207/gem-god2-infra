variable "aws_type" {}
variable "key_name" {}
variable "vpc" {}
variable "route53" {}
variable "aws_profile" {}
variable "aurora-mysql" {}
variable "acm" {}
variable "ec2-api2" {}
variable "ec2-crawler" {}
variable "ec2-mgmt" {}
variable "ec2-unity" {}

locals {
  domain           = var.route53.name
  local_domain     = format("%s.aws", local.domain)
  host-ssh-api2    = "api2.${var.aws_type}.gem-dev"
  host-ssh-crawler = "crawler.${var.aws_type}.gem-dev"
  host-ssh-mgmt    = "mgmt.${var.aws_type}.gem-dev"
  host-ssh-unity    = "unity.${var.aws_type}.gem-dev"
  appconfig        = "${path.cwd}/../../../appconfig/${var.aws_type}"
}
