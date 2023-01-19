variable "route_table_private" {}
# -------------------
# crawler-data
# -------------------
module "s3-crawler" {
  source = "../s3/crawler"
  bucket = format("crawler.s3.%s", local.local_domain)
  #	alb-prefixes = ["crawler"]
  vpc = var.vpc
  route_table_private_ids = [
    for s in var.vpc.route_table_private : s.id
  ]

}
resource "local_file" "s3-crawler" {
  content         = yamlencode(module.s3-crawler)
  filename        = "${path.cwd}/s3-crawler.sh"
  file_permission = 0644
}
