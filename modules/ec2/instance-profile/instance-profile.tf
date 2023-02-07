variable "name" { default = "StandardInstanceProfile" }
variable "domain_name" {}
variable "aws_type" {}

resource "aws_iam_role" "r" {
  name               = var.name
  assume_role_policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOT
}

resource "aws_iam_policy" "s3c" {
  name = "s3_custom_policy"

  policy = jsonencode({

    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
#          "s3:*"
          				"s3:PutObject",
          				"s3:GetObject",
          				"s3:DeleteObject",
          				"s3:RutObjectAcl",
          				"s3:ListObject",
          				"s3:ListBucket"
        ],

        "Resource" : [
          #	"*"
          "arn:aws:s3:::${var.aws_type}-god.s3.${var.domain_name}.aws-data",
          "arn:aws:s3:::${var.aws_type}-god.s3.${var.domain_name}.aws-data/*",
          "arn:aws:s3:::${var.aws_type}-site-info.s3.${var.domain_name}.aws-data",
          "arn:aws:s3:::${var.aws_type}-site-info.s3.${var.domain_name}.aws-data/*",
          "arn:aws:s3:::${var.aws_type}-crawler.s3.${var.domain_name}.aws-data",
          "arn:aws:s3:::${var.aws_type}-crawler.s3.${var.domain_name}.aws-data/*"
        ]
      }
    ]
  })
}

output "aws_iam_policy_s3c" {
  value = aws_iam_policy.s3c
}

resource "aws_iam_instance_profile" "p" {
  name = var.name
  role = aws_iam_role.r.name
}

# CloudWatch
resource "aws_iam_role_policy_attachment" "cw" {
  role       = aws_iam_role.r.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

# SSM
# https://docs.aws.amazon.com/ja_jp/systems-manager/latest/userguide/setup-instance-profile.html
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.r.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "s3c" {
  role       = aws_iam_role.r.name
  policy_arn = aws_iam_policy.s3c.arn
}

output "instance-profile" {
  value = aws_iam_instance_profile.p
}
