# -------------------
# s3-god
# -------------------
module "s3-god" {
  source = "../s3/god"
  bucket = format("god.s3.%s", local.local_domain)
  #  bucket = god.s3
  vpc      = var.vpc
  aws_type = var.aws_type
  route_table_private_ids = [
    for s in var.vpc.route_table_private : s.id
  ]
  #  endpoint = module.s3-crawler.endpoint_id
}
