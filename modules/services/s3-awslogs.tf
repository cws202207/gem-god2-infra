# -------------------
# awslogs
# -------------------
module "s3-awslogs" {
  source = "../s3/awslogs"
  bucket = format("awslogs.s3.%s", local.local_domain)
  #	alb-prefixes = ["api2"]
}

resource "local_file" "s3-awslogs" {
  content         = yamlencode(module.s3-awslogs)
  filename        = "${path.cwd}/../s3.sh"
  file_permission = "0600"
}

output "bucket" {
  value = module.s3-awslogs.bucket.bucket
}

output "caller" {
	value = module.s3-awslogs.bucket_policy
}
