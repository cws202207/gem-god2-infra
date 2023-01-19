locals {
  security_group_ids = {
    vpc      = var.vpc.security_groups.vpc
    private  = var.vpc.security_groups.private
    web-alb  = aws_security_group.web-alb.id
    web-alb2 = aws_security_group.web-alb2.id
    alb-ec2  = aws_security_group.alb-ec2.id
    web      = var.vpc.security_groups.web
  }
}

resource "aws_security_group" "web-alb" {
  vpc_id      = var.vpc.vpc_id
  name        = "Web-ALB"
  description = "managed by terraform"
  tags = {
    Name = "Web-ALB"
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "http"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  # HTTPS
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "https"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}

resource "aws_security_group" "web-alb2" {
  vpc_id      = var.vpc.vpc_id
  name        = "Web-ALB2"
  description = "managed by terraform"
  tags = {
    Name = "Web-ALB2"
  }
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

  # HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "http"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }

}

resource "aws_security_group" "alb-ec2" {
  vpc_id      = var.vpc.vpc_id
  name        = "ALB-EC2"
  description = "managed by terraform"
  tags = {
    Name = "ALB-EC2"
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
