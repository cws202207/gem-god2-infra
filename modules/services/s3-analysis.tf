# -------------------
# analysis  分析データ管理システム用S3
# -------------------
module "s3-analysis" {
  source = "../s3/analysis"
  bucket = format("analysis.s3.%s", local.local_domain)
  vpc    = var.vpc
  aws_type = var.aws_type
  route_table_private_ids = [
    for s in var.vpc.route_table_private : s.id
  ]
}
