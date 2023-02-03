variable "route_table_private" {}
# -------------------
# crawler-data
# -------------------
module "s3-crawler" {
  source = "../s3/crawler"
  bucket = format("crawler.s3.%s", local.local_domain)
  vpc = var.vpc
  aws_type = var.aws_type
  route_table_private_ids = [
    for s in var.vpc.route_table_private : s.id
  ]

}
