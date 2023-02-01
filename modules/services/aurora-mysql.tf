# -------------------------------
# Database site-infoを作成
# -------------------------------
module "site-info-aurora-mysql" {
  source = "../aurora-mysql/site-info-aurora-mysql"
  name   = "site-info"
  vpc_id = var.vpc.vpc_id
  subnet_ids = [
    for s in var.vpc.subnet_public : s.id
  ]
  production = var.aurora-mysql.production

  # アクセスを許可するローカルアドレス
  permit_ips = [
    {
      #"module.ec2-crawler.crawler_private_ip"で囲むと文字列になってしまうので、気を付ける 囲んで渡すとlist of string required.

      name = "god-hand"
      ip   = module.god-hand.god-hand_private_ip
    },
    {
      name = "god-api"
      ip   = module.god-api.god-api_private_ip
    }
  ]
  aurora = {
    availability_zones = [
      for s in var.vpc.availability_zone : s
    ]
    class = "db.t4g.medium"
  }
}

# -------------------------------
# Database godを作成
# -------------------------------

module "god-aurora-mysql" {
  source = "../aurora-mysql/god-aurora-mysql"
  name   = "god"
  vpc_id = var.vpc.vpc_id
  subnet_ids = [
    for s in var.vpc.subnet_public : s.id
  ]
  production = var.aurora-mysql.production

  # アクセスを許可するローカルアドレス
  permit_ips = [
    {
      name = "god-api"
      ip   = module.god-api.god-api_private_ip #mgmtのみアクセス許可
    },
    {
      name = "god-hand"
      ip   = module.god-hand.god-hand_private_ip
    }

  ]
  aurora = {
    availability_zones = [
      for s in var.vpc.availability_zone : s
    ]
    class = "db.t4g.medium"
  }
}


# -------------------------------
# Database god-preを作成
# -------------------------------

module "god-pre-aurora-mysql" {
  source = "../aurora-mysql/god-pre-aurora-mysql"
  name   = "god-pre"
  vpc_id = var.vpc.vpc_id
  subnet_ids = [
    for s in var.vpc.subnet_public : s.id
  ]
  production = var.aurora-mysql.production

  # アクセスを許可するローカルアドレス
  permit_ips = [
    {
      name = "god-batch"
      ip   = module.god-batch.god-batch_private_ip #mgmtのみアクセス許可
    },
    {
      name = "god-hand"
      ip   = module.god-hand.god-hand_private_ip
    }

  ]
  aurora = {
    availability_zones = [
      for s in var.vpc.availability_zone : s
    ]
    class = "db.t4g.medium"
  }
}

resource "local_file" "site-info-aurora-mysql" {
  content         = yamlencode(module.site-info-aurora-mysql)
  filename        = "${path.cwd}/../etc/site-info.aurora-mysql.sh"
  file_permission = 0644
}

resource "local_file" "god-aurora-mysql" {
  content         = yamlencode(module.god-aurora-mysql)
  filename        = "${path.cwd}/../etc/god.aurora-mysql.sh"
  file_permission = "0644"
}

resource "local_file" "god-pre-aurora-mysql" {
  content = yamlencode(module.god-pre-aurora-mysql)
  filename = "${path.cwd}/../etc/god-pre.aurora-mysql.sh"
  file_permission = "0644"
}
