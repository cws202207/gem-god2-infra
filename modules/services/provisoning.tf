# ------------------------------
# api2用のインスタンス作成
# ------------------------------

module "provisioning-api2" {
  source = "../ec2/provisioning/api2"
  depends_on = [
    module.ec2-api2,
    local_file.ssh_config,
    local_file.crawl-data_my_cnf
  ]
  instance_id   = module.ec2-api2.api2_id
  dir_appconfig = "${local.appconfig}/etc"
  ssh = {
    config = "${local.appconfig}/etc/ssh/config"
    host   = "auto.${local.host-ssh-api2}"
  }
}

# ------------------------------ 
# api2用ローカルファイル作成
# ------------------------------

resource "local_file" "provisioning" {
  content         = yamlencode(module.provisioning-api2)
  filename        = "${path.cwd}/../ssh_cmd.sh"
  file_permission = 0644
}

# ------------------------------ 
# 管理サーバ用のインスタンス作成
# ------------------------------

module "provisioning-mgmt" {
  source = "../ec2/provisioning/mgmt"
  depends_on = [
    module.ec2-mgmt,
    local_file.mgmt_ssh_config,
    local_file.crawl-data_my_cnf
  ]
  instance_id   = module.ec2-mgmt.mgmt_id
  dir_appconfig = "${local.appconfig}/etc"
  ssh = {
    config = "${local.appconfig}/etc/ssh/mgmt/config"
    host   = "auto.${local.host-ssh-mgmt}"
  }
}

output "provisioning_mgmt_ssh" {
  value = module.provisioning-mgmt.ssh_cmd
}

# -----------------------------------
# 管理サーバ用のローカルファイル作成
# -----------------------------------

resource "local_file" "mgmt-provisioning" {
  content         = yamlencode(module.provisioning-mgmt)
  filename        = "${path.cwd}/../mgmt_ssh_cmd.sh"
  file_permission = 0644
}

# ------------------------------
# クローラ用のインスタンス作成
# ------------------------------

module "provisioning-crawler" {
  source = "../ec2/provisioning/crawler"
  depends_on = [
    module.ec2-crawler,
    local_file.crawler_ssh_config,
    local_file.crawl-data_my_cnf
  ]
  instance_id   = module.ec2-crawler.crawler_id
  dir_appconfig = "${local.appconfig}/etc"
  ssh = {
    config = "${local.appconfig}/etc/ssh/crawler/config"
    host   = "auto.${local.host-ssh-crawler}"
  }
}

# -----------------------------------
# クローラ用のローカルファイル作成
# -----------------------------------

resource "local_file" "crawler-provisioning" {
  content         = yamlencode(module.provisioning-crawler)
  filename        = "${path.cwd}/../crawler_ssh_cmd.sh"
  file_permission = 0644
}

# ------------------------------
# 名寄せツール用のインスタンス作成
# ------------------------------

module "provisioning-unity" {
	source = "../ec2/provisioning/unity"
	depends_on = [
	  module.ec2-unity,
	  local_file.unity_ssh_config,
#	  local_file.unity_my_cnf
	]
	instance_id = module.ec2-unity.unity_id
	dir_appconfig = "${local.appconfig}/etc"
	ssh = {
	  config = "${local.appconfig}/etc/ssh/unity/config"
	  host = "auto.${local.host-ssh-unity}"
	}
}

# -----------------------------------
# 名寄せツール用のローカルファイル作成
# -----------------------------------

resource "local_file" "unity-provisioning" {
  content         = yamlencode(module.provisioning-unity)
  filename        = "${path.cwd}/../unity_ssh_cmd.sh"
  file_permission = 0644
}
