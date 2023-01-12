data "aws_caller_identity" "self" {}
data "aws_elb_service_account" "current" {}

resource "aws_s3_bucket_policy" "b" {
  bucket = aws_s3_bucket.b.id
  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
          "AWS" : "arn:aws:iam::${data.aws_elb_service_account.current.id}:root" },
          "Action" : "s3:PutObject",
          "Resource" : "arn:aws:s3:::${aws_s3_bucket.b.id}/*"
#          "Resource" : "arn:aws:s3:::${aws_s3_bucket.b.id}/AWSLogs/${data.aws.caller_identity.self.account_id}/*"
        },
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "delivery.logs.amazonaws.com"
          },
          "Action" : "s3:PutObject",
          "Resource" : "arn:aws:s3:::${aws_s3_bucket.b.id}/*",
#          "Resource" : "arn:aws:s3:::${aws_s3_bucket.b.id}/AWSLogs/${data.aws.caller_identity.self.account_id}/*"
          "Condition" : {
            "StringEquals" : {
              "s3:x-amz-acl" : "bucket-owner-full-control"
            }
          }
        },
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "delivery.logs.amazonaws.com"
          },
          "Action" : "s3:GetBucketAcl",
          "Resource" : "arn:aws:s3:::${aws_s3_bucket.b.id}"
        }
      ]
    }
  )
}

