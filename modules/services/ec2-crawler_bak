module "ec2-crawler" {
  source      = "../ec2/instance/crawler"
  name        = "crawler"
  fqdn        = "crawler.${local.domain}"
  type        = var.ec2-crawler.type
  size        = var.ec2-crawler.size
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

# ALB HTTP
module "alb-crawler" {
	source = "../alb/crawler"
	name = "crawler"
	vpc_id = var.vpc.vpc_id
	subnets = [
		for s in var.vpc.subnet_public : s.id
]
security_group_ids = local.security_group_ids
targets = [
	{
	name = "crawler"
	priority = 60
	instance_id = module.ec2-crawler.crawler_id
	port = 80
	health_check = "/health_check.txt"
}
]	
}

resource "local_file" "alb-crawler" {
	content = yamlencode(module.alb-crawler)
	filename = "${path.cwd}/../alb-crawler.sh"
	file_permission = 0644
}
