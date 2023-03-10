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

# ------------------------
# エンドポイント
# ------------------------
resource "aws_vpc_endpoint" "crawler_endpoint" {
  vpc_id       = var.vpc.vpc_id
  service_name = "com.amazonaws.ap-northeast-1.s3"
  policy = jsonencode({
    Version = "2012-10-17"
    "Statement" : [
      {
        Action = [
          "s3:*"
          #          "s3:PutObject",
          #          "s3:GetObject",
          #          "s3:DeleteObject",
          #          "s3:RutObjectAcl",
          #          "s3:ListObject",
          #          "s3:ListBucket"
        ]
        "Effect" : "Allow",
        "Resource" : [
          "*"
          #          "arn:aws:s3:::${local.name_prefix}-${var.bucket}-data",
          #          "arn:aws:s3:::${local.name_prefix}-${var.bucket}-data/*"
        ],
        "Principal" : "*"
      }
    ]
  })
}

# ------------------------
# エンドポイント ルートテーブル
# ------------------------
resource "aws_vpc_endpoint_route_table_association" "private_s3" {
  vpc_endpoint_id = aws_vpc_endpoint.crawler_endpoint.id
  count           = length(var.route_table_private_ids)
  route_table_id  = var.route_table_private_ids[count.index]
}

output "aws_vpc_endpoint_id" {
  value = aws_vpc_endpoint.crawler_endpoint.id
}
