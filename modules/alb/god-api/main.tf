variable "name" {}
variable "subnets" {}
variable "security_group_ids" {}
variable "vpc_id" {}
variable "route53_zone_id" {}
variable "log_bucket" { default = "alb" }
variable "log_prefix" { default = "alb" }
variable "redirectors" {}
variable "targets" {}
variable "acm" {}

locals {
  ports_uniq = distinct([for d in var.targets : d.port])
}

# --------------
# EC2で許可するポート
# --------------
resource "aws_security_group_rule" "god-api" {
  count                    = length(local.ports_uniq)
  type                     = "ingress"
  from_port                = local.ports_uniq[count.index]
  to_port                  = local.ports_uniq[count.index]
  protocol                 = "tcp"
  source_security_group_id = var.security_group_ids.web-alb
  security_group_id        = var.security_group_ids.alb-ec2
}

# --------------
# ロードバランサ
# --------------
resource "aws_lb" "l" {
  name                       = var.name
  security_groups            = [var.security_group_ids.web-alb]
  subnets                    = var.subnets
  internal                   = false
  enable_deletion_protection = false
  access_logs {
    bucket  = var.log_bucket
    prefix  = var.log_prefix
    enabled = true
  }
  #  depends_on = [ aws_lb_listener.http, aws_lb_listener.https ]
}

#output "rule_ec2" {
#  value = aws_security_group_rule.ec2
#}

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
  count            = length(var.targets)
  target_group_arn = aws_lb_target_group.l[count.index].arn
  target_id        = var.targets[count.index].instance_id
  port             = var.targets[count.index].port
}

# --------------
# リスナー
# --------------
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.l.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
  #  depends_on = [ aws_lb.l ]
}

# --------------
# default 404
# --------------

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.l.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2015-05"
  certificate_arn   = var.acm
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = 404
    }
  }
}

# --------------
# リスナールール
# --------------
# リダイレクター
resource "aws_lb_listener_rule" "red" {
  count        = length(var.redirectors)
  listener_arn = aws_lb_listener.http.arn
  priority     = var.redirectors[count.index].priotiry
  action {
    type = "redirect"
    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTPS_301"
      host        = var.redirectors[count.index].to
    }
  }
  condition {
    host_header {
      values = [var.redirectors[count.index].from]
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

output "aws_lb_l" {
  value = aws_lb.l
}

output "aws_lb_listener_rule_red" {
  value = aws_lb_listener_rule.red
}


# --------------
# ドメインマッチ
# --------------
resource "aws_lb_listener_rule" "dest" {
  count        = length(var.targets)
  listener_arn = aws_lb_listener.https.arn
  priority     = var.targets[count.index].priority
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.l[count.index].arn
  }
  condition {
    host_header {
      values = [var.targets[count.index].domain]
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

output "aws_lb_listener_rule_dest" {
  value = aws_lb_listener_rule.dest
}

output "public_subnets" {

  value = aws_lb.l.subnets
}


resource "aws_route53_record" "dest" {
  count   = length(var.targets)
  zone_id = var.route53_zone_id
  name    = var.targets[count.index].domain
  type    = "A"
  alias {
    name                   = aws_lb.l.dns_name
    zone_id                = aws_lb.l.zone_id
    evaluate_target_health = true
  }
}


resource "aws_route53_record" "red" {
  count   = length(var.redirectors)
  zone_id = var.route53_zone_id
  name    = var.redirectors[count.index].from
  type    = "A"
  alias {
    name                   = aws_lb.l.dns_name
    zone_id                = aws_lb.l.zone_id
    evaluate_target_health = true
  }
}

output "fqdns" {
  value = concat(
    [for r in aws_route53_record.dest : r.fqdn],
    [for r in aws_route53_record.red : r.fqdn],
  )
}
output "alb" {
  value = aws_lb.l.access_logs
}

output "red_god_api" {
	value = aws_route53_record.red
}
