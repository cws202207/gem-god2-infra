# -------------------
# crawler-data
# -------------------
module "s3-unity" {
  source = "../s3/unity"
  bucket = format("unity.s3.%s", local.local_domain)
  vpc    = var.vpc
  route_table_private_ids = [
    for s in var.vpc.route_table_private : s.id
  ]
  #  endpoint = module.s3-crawler.endpoint_id
}
