# -------------------------------------------
# RDS拡張モニタリング
# https://docs.aws.amazon.com/ja_jp/AmazonRDS/latest/UserGuide/USER_Monitoring.OS.html
# -------------------------------------------
resource "aws_iam_role" "emon" {
  name               = "${var.name}-rds_emon"
  assume_role_policy = <<EOT
{
	"Version" : "2012-10-17",
	"Statement" : [
		{
			"Sid": "",
			"Effect" : "Allow",
			"Principal" : {
				"Service" : "monitoring.rds.amazonaws.com"
		},
		"Action" : "sts:AssumeRole"
	}
]
}
EOT
}
resource "aws_iam_role_policy_attachment" "emon" {
  role       = aws_iam_role.emon.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
