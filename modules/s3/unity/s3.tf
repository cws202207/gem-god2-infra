variable "bucket" {}
variable "vpc" {}
variable "route_table_private_ids" {}

resource "aws_s3_bucket" "c" {
  bucket = "${local.name_prefix}-${var.bucket}-data"

  tags = {
    Name = "${local.name_prefix}-${var.bucket}-data"
  }
}

resource "null_resource" "remove" {
  triggers = {
    bucket = aws_s3_bucket.c.bucket
  }
  depends_on = [
    aws_s3_bucket.c
  ]
  provisioner "local-exec" {
    when    = destroy
    command = "aws s3 rm s3://${self.triggers.bucket} --recursive"
  }
}
#resource "aws_s3_bucket_server_side_encryption_configuration" "encyption" {
#  bucket = "${local.name_prefix}-${var.bucket}-data"
#  rule {
#    apply_server_side_encryption_by_default {
#      sse_algorithm = "AES256"
#    }
#  }
#}

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = "${local.name_prefix}-${var.bucket}-data"
  rule {
    id = "${var.bucket}-rule"

    expiration {
      days = 180
    }

    status = "Enabled"
  }
}

