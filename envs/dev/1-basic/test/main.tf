data "aws_route53_zone" "z" {
  name         = "gem-entertainment-standard-dev.net."
  private_zone = false
}

output "name" {
  value = data.aws_route53_zone.z.name
}
