# -------------------
# sito-info
# -------------------
module "s3-sito-info" {
  source = "../s3/site-info"
  bucket = format("site-info.s3.%s", local.local_domain)
  #  bucket = site-info.s3
  vpc = var.vpc
  route_table_private_ids = [
    for s in var.vpc.route_table_private : s.id
  ]
  #  endpoint = module.s3-crawler.endpoint_id
}
