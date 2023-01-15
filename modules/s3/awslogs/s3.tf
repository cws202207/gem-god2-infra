variable "bucket" {}

resource "aws_s3_bucket" "b" {
  bucket = "${var.bucket}-alb-log"

  tags = {
    Name = "${var.bucket}-alb-log"
  }
}

#resource "aws_s3_bucket_server_side_encryption_configuration" "encyption" {
#  bucket = "${var.bucket}-alb-log"
#  rule {
#    apply_server_side_encryption_by_default {
#      sse_algorithm = "AES256"
#    }
#  }
#}

#resource "null_resource" "remove" {
#  triggers = {
#    bucket = aws_s3_bucket.b.bucket
#  }
#  depends_on = [
#    aws_s3_bucket.b
#  ]
#  provisioner "local-exec" {
#    when    = destroy
#    command = "aws s3 rm s3://${self.triggers.bucket} --recursive"
#  }
#}


#resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
#  bucket = "${var.bucket}-alb-log"
#  rule {
#    id = "${var.bucket}"
#
#    expiration {
#      days = 90
#    }
#
#    status = "Enabled"
#  }
#}

output "bucket" {
  value = aws_s3_bucket.b
}

output "bucket_domain_name" {
  value = aws_s3_bucket.b.bucket_domain_name
}

output "bucket_regional_domain_name" {
  value = aws_s3_bucket.b.bucket_regional_domain_name
}
