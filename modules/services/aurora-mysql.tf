# -------------------------------
# Database crawlerを作成
# -------------------------------
module "crawl-aurora-mysql" {
  source = "../aurora-mysql"
  name   = "crawl-data"
  vpc_id = var.vpc.vpc_id
  subnet_ids = [
    for s in var.vpc.subnet_public : s.id
  ]
  production = var.aurora-mysql.production

  # アクセスを許可するローカルアドレス
  permit_ips = [
    {
      #"module.ec2-crawler.crawler_private_ip"で囲むと文字列になってしまうので、気を付ける 囲んで渡すとlist of string required.

      name = "crawler"
      ip   = module.ec2-crawler.crawler_private_ip
    },
    {
      name = "api2"
      ip   = module.ec2-api2.api2_private_ip
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
# Database ip-masterを作成
# -------------------------------

module "ip-master" {
  source = "../aurora-mysql/ip-master-aurora"
  name   = "ip-master"
  vpc_id = var.vpc.vpc_id
  subnet_ids = [
    for s in var.vpc.subnet_public : s.id
  ]
  production = var.aurora-mysql.production

  # アクセスを許可するローカルアドレス
  permit_ips = [
    {
      name = "mgmt"
      ip   = module.ec2-mgmt.mgmt_private_ip #mgmtのみアクセス許可
    },
	{
	name = "unity"
	ip = module.ec2-unity.unity_private_ip
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
# Database ip-masterを作成
# -------------------------------

module "pre-ip-master" {
  source = "../aurora-mysql/pre-ip-master-aurora"
  name   = "pre-ip-master"
  vpc_id = var.vpc.vpc_id
  subnet_ids = [
    for s in var.vpc.subnet_public : s.id
  ]
  production = var.aurora-mysql.production

  # アクセスを許可するローカルアドレス
  permit_ips = [
    {
      name = "mgmt"
      ip   = module.ec2-mgmt.mgmt_private_ip
    }
  ]
  aurora = {
    availability_zones = [
      for s in var.vpc.availability_zone : s
    ]
    class = "db.t4g.medium"
  }
}

resource "local_file" "pre" {
	content = yamlencode(module.pre-ip-master)
	filename = "${path.cwd}/pre.aurora-mysql.sh"
	file_permission = 0644
}
