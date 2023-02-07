variable "bucket" {}
variable "vpc" {}
variable "route_table_private_ids" {}
variable "aws_type" {}

resource "aws_s3_bucket" "c" {
  bucket = "${var.aws_type}-${var.bucket}-data"

  tags = {
    Name = "${local.name_prefix}-${var.bucket}-data"
  }
}

resource "aws_s3_bucket_versioning" "v" {
  bucket = aws_s3_bucket.c.id
  versioning_configuration {
    status = "Enabled"
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

resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = "${var.aws_type}-${var.bucket}-data"
  rule {
    id = "${var.aws_type}-${var.bucket}-rule"

    expiration {
      days = 180
    }

    status = "Enabled"
  }
}

