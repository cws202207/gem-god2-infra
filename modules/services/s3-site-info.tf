# -------------------
# sito-info
# -------------------
module "s3-sito-info" {
  source = "../s3/site-info"
  bucket = format("site-info.s3.%s", local.local_domain)
  vpc = var.vpc
  aws_type = var.aws_type
  route_table_private_ids = [
    for s in var.vpc.route_table_private : s.id
  ]
}
