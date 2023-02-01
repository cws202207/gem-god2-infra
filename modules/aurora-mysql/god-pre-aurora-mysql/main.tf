variable "vpc_id" {}
variable "subnet_ids" {}
variable "permit_ips" {}
variable "aurora" {}
variable "name" {}

variable "production" { default = false }

output "aurora" {
  value = var.aurora
}
output "subnet_ids" {
  value = var.subnet_ids
}
output "pertmit_ips" {
  value = var.permit_ips
}

resource "random_string" "god_password" {
  length           = 32
  special          = true
  override_special = "!*()-_=+[]{}<>:"
}

locals {
  master = {
    db       = "master"
    username = "master"
    password = random_string.master_password.id
  }
  god-pre = {
    db       = "god_pre"
    username = "god_pre"
    password = random_string.god_password.id
  }
}

output "cluster" {
  value = aws_rds_cluster.d
}
output "instance" {
  value = aws_rds_cluster.d
}
output "endpoint" {
  value = aws_rds_cluster.d.endpoint
}
output "reader_endpoint" {
  value = aws_rds_cluster.d.reader_endpoint
}
output "port" {
  value = aws_rds_cluster.d.port
}
output "master" {
  value = local.master
}
output "god-pre" {
  value = local.god-pre
}
