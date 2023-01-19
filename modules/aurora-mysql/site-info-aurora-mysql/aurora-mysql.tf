# backup Windows開始分をランダムにする？
resource "random_integer" "backup" {
  min = 0
  max = 59
  keepers = {
    name = var.name
  }
}
resource "random_integer" "maintenance" {
  min = 0
  max = 59
  keepers = {
    name = var.name
  }
}

locals {
  backup_window = format("18:%02d-19:%02d", random_integer.backup.result, random_integer.backup.result)
}

output "backup_window" {
  value = local.backup_window
}

# マスターパスワード
resource "random_string" "master_password" {
  length           = 32
  special          = true
  override_special = "!*()-_=+[]{}<>:"
}

output "master_password" {
  value = random_string.master_password
}

# パラメータグループ
resource "aws_rds_cluster_parameter_group" "d" {
  name   = var.name
  family = "aurora-mysql8.0"
  parameter {
    name         = "character_set_server"
    value        = "utf8mb4"
    apply_method = "immediate" #Defaultがimmediateなので省略化
  }
  parameter {
    name         = "character_set_client"
    value        = "utf8mb4"
    apply_method = "immediate"
  }
  parameter {
    name         = "character_set_connection"
    value        = "utf8mb4"
    apply_method = "immediate"
  }
  parameter {
    name         = "character_set_database"
    value        = "utf8mb4"
    apply_method = "immediate"
  }
  parameter {
    name         = "character_set_filesystem"
    value        = "utf8mb4"
    apply_method = "immediate"
  }
  parameter {
    name         = "character_set_results"
    value        = "utf8mb4"
    apply_method = "immediate"
  }
  parameter {
    name         = "collation_server"
    value        = "utf8mb4_general_ci"
    apply_method = "immediate"
  }
  parameter {
    name         = "time_zone"
    value        = "Asia/Tokyo"
    apply_method = "immediate"
  }
}
output "aws_rds_cluster_parameter_group" {
  value = aws_rds_cluster_parameter_group.d
}
output "aws_rds_cluster_parameter_group_name" {
  value = aws_rds_cluster_parameter_group.d.name
}

resource "aws_db_parameter_group" "d" {
  name   = var.name
  family = "aurora-mysql5.7"
}

resource "aws_rds_cluster" "d" {
  cluster_identifier              = var.name
  engine                          = "aurora-mysql"
  engine_version                  = "8.0.mysql_aurora.3.02.0"
  availability_zones              = var.aurora.availability_zones
  database_name                   = local.site-info.db
  master_username                 = local.site-info.username
  master_password                 = local.site-info.password
  port                            = 3306
  backup_retention_period         = 5
  preferred_backup_window         = local.backup_window
  db_subnet_group_name            = aws_db_subnet_group.private.name
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.d.name
  vpc_security_group_ids          = [aws_security_group.rds.id]

  skip_final_snapshot = var.production ? false : true
  apply_immediately   = var.production ? false : true
}

resource "aws_rds_cluster_instance" "d" {
  count = var.production ? 3 : 1

  cluster_identifier = aws_rds_cluster.d.id
  identifier         = "${var.name}-i${count.index}"

  engine         = aws_rds_cluster.d.engine
  engine_version = aws_rds_cluster.d.engine_version
  instance_class = var.aurora.class

  monitoring_role_arn = aws_iam_role.emon.arn
  monitoring_interval = 60

  publicly_accessible = true
}
