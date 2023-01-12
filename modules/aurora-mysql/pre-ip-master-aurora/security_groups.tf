# -------------------
# RDS Security Group
# -------------------
resource "aws_security_group" "rds" {
  vpc_id      = var.vpc_id
  name        = "${var.name}-DB-RDS"
  description = "managed by terraform"
  tags = {
    Name = "DB-RDS"
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}


# 許可するIPアドレスの追加
resource "aws_security_group_rule" "mysql" {
  count       = length(var.permit_ips)
  type        = "ingress"
  from_port   = 3306
  to_port     = 3306
  protocol    = "tcp"
  cidr_blocks = [format("%s/32", var.permit_ips[count.index].ip)]
  description       = var.permit_ips[count.index].name
  security_group_id = aws_security_group.rds.id
}

output "mysql_security_rule" {
  value = aws_security_group_rule.mysql
}

output "permit_ip" {
  value = var.permit_ips
}

output "aws_security_group_rds" {
	value = aws_security_group.rds
}
