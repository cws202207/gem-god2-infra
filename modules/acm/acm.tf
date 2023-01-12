variable "domain_name" {}
variable "domain_zone_id" {}

locals {
	domain_name = var.domain_name
	hosted_zone_id = var.domain_zone_id
}

resource "aws_acm_certificate" "root" {
  domain_name = var.domain_name

  validation_method = "DNS"

  tags = {
    Name = "${local.name_prefix}-appfoobar-link"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "root" {
  certificate_arn = aws_acm_certificate.root.arn
}

output "domain_name" {
	value = local.domain_name
}

output "hosted_zone_id" {
	value = local.hosted_zone_id
}

output "aws_acm_certificate_arn" {
	value = aws_acm_certificate.root.arn
}
