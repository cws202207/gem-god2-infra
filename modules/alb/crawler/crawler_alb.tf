variable "name" {}
variable "subnets" {}
variable "security_group_ids" {}
variable "vpc_id" {}
# variable "route53_zone_id" {}
# variable "log_bucket" { default = "alb" }
# variable "log_prefix" { default = "alb" }
# variable "redirectors" {}
variable "targets" {}
# variable "acm" {}

locals {
  ports_uniq = distinct([for d in var.targets : d.port])
}

output "ports_uniq" {
 value = local.ports_uniq
}

output "ports_uniq_length" {
 value = length(local.ports_uniq)
}

output "var_targets_length" {
 value = length(var.targets)
}

# --------------
# EC2で許可するポート
# --------------
resource "aws_security_group_rule" "ec2-crawler" {
  count                    = length(local.ports_uniq)
  type                     = "ingress"
  from_port                = local.ports_uniq[count.index]
  to_port                  = local.ports_uniq[count.index]
  protocol                 = "tcp"
  source_security_group_id = var.security_group_ids.web-alb2
  security_group_id        = var.security_group_ids.alb-ec2
}

# --------------
# ロードバランサ
# --------------
resource "aws_lb" "l" {
  name                       = var.name
  security_groups            = [var.security_group_ids.web-alb2]
  subnets                    = var.subnets
  internal                   = false
  enable_deletion_protection = false
#  access_logs {
#    bucket = var.log_bucket
#    prefix = var.log_prefix
#    enabled = true
#  }
}
output "aws_crawler_dns" {
	value = aws_lb.l.dns_name
}

output "rule_ec2" {
  value = aws_security_group_rule.ec2-crawler
}

# --------------
# ターゲットグループ
# --------------
resource "aws_lb_target_group" "l" {
  count    = length(var.targets)
  name     = "${var.name}-${var.targets[count.index].name}"
  port     = var.targets[count.index].port
  vpc_id   = var.vpc_id
  protocol = "HTTP"
  health_check {
    path                = var.targets[count.index].health_check
    interval            = 60
    port                = var.targets[count.index].port
    protocol            = "HTTP"
    timeout             = 5
 unhealthy_threshold = 2
    matcher             = 200
  }
}

resource "aws_lb_target_group_attachment" "l" {
	count = length(var.targets)
	target_group_arn = aws_lb_target_group.l[count.index].arn
	target_id = var.targets[count.index].instance_id
	port = var.targets[count.index].port
}

# --------------
# リスナー
# --------------
resource "aws_lb_listener" "http" {
count = length(var.targets)
  load_balancer_arn = aws_lb.l.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "forward"
	target_group_arn = aws_lb_target_group.l[count.index].arn
#    redirect {
#      port        = "443"
#      protocol    = "HTTPS"
#      status_code = "HTTP_301"
#    }
  }
}

output "aws_lb_l" {
	value = aws_lb.l
}

