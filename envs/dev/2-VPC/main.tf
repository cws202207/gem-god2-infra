locals {
  domain = yamldecode(file("${path.cwd}/../etc/tf-route53.yaml"))
  name   = format("gem-es2-%s", file("../etc/awstype"))
}

# VPC
module "aws_vpc" {
  source = "../../../modules/vpc"
  name = local.name

}
# VPC Localfile create
resource "local_file" "aws_vpc_this" {
  content         = yamlencode(module.aws_vpc)
  filename        = "${path.cwd}/../etc/tf-vpc.yaml"
  file_permission = "0600"
}

module "acm" {
  source = "../../../modules/acm"
  domain_name = local.domain.name
  domain_zone_id = local.domain.zone_id
}

# acm Localfile create
 resource "local_file" "acm" {
   content         = yamlencode(module.acm)
   filename        = "${path.cwd}/../etc/tf-acm.yaml"
   file_permission = "0600"
}

# Instance profle create
module "instance-profile" {
  source = "../../../modules/ec2/instance-profile"
  name   = "StandardInstanceProfile"
  domain_name = local.domain.name
}

# instance-profile localfile create
 resource "local_file" "instance-profile" {
	content = yamlencode(module.instance-profile)
	filename = "${path.cwd}/../etc/tf-instance-profile.yaml"
	file_permission = "0600"
}
