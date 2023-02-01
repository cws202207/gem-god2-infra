# ------------------------------
# god-api用のインスタンス作成
# ------------------------------

module "provisioning-god-api" {
  source = "../ec2/provisioning/god-api"
  depends_on = [
    module.god-api,
    local_file.ssh_config,
    local_file.site-info_my_cnf
  ]
  instance_id    = module.god-api.god-api_id
  dir_appconfig  = "${local.appconfig}/etc"
  dir_public_key = local.public_key
  ssh = {
    config = "${local.appconfig}/etc/ssh/god-api/config"
    host   = "auto.${local.host-ssh-god-api}"
  }
}

# ------------------------------ 
# god-api用ローカルファイル作成
# ------------------------------

resource "local_file" "provisioning" {
  content         = yamlencode(module.provisioning-god-api)
  filename        = "${path.cwd}/../ssh_cmd.sh"
  file_permission = 0644
}

# ------------------------------ 
# サイト集計システム用のインスタンス作成
# ------------------------------

module "provisioning-god-batch" {
  source = "../ec2/provisioning/god-batch"
  depends_on = [
    module.god-batch,
    local_file.god-batch_ssh_config,
    local_file.site-info_my_cnf,
    #    local_file.god_my_cnf,
  ]
  instance_id   = module.god-batch.god-batch_id
  dir_appconfig = "${local.appconfig}/etc"
  dir_public_key = local.public_key
  ssh = {
    config = "${local.appconfig}/etc/ssh/god-batch/config"
    host   = "auto.${local.host-ssh-god-batch}"
  }
}

output "provisioning_god-batch_ssh" {
  value = module.provisioning-god-batch.ssh_cmd
}

# -----------------------------------
# サイト集計システム用のローカルファイル作成
# -----------------------------------

resource "local_file" "god-batch-provisioning" {
  content         = yamlencode(module.provisioning-god-batch)
  filename        = "${path.cwd}/../god-batch_ssh_cmd.sh"
  file_permission = 0644
}

# ------------------------------
# クローラ用のインスタンス作成
# ------------------------------

#module "provisioning-crawler" {
#  source = "../ec2/provisioning/crawler"
#  depends_on = [
#    module.ec2-crawler,
#    local_file.crawler_ssh_config,
#    local_file.site-info_my_cnf
#  ]
#  instance_id   = module.ec2-crawler.crawler_id
#  dir_appconfig = "${local.appconfig}/etc"
#  ssh = {
#    config = "${local.appconfig}/etc/ssh/crawler/config"
#    host   = "auto.${local.host-ssh-crawler}"
#  }
#}

# -----------------------------------
# クローラ用のローカルファイル作成
# -----------------------------------

#resource "local_file" "crawler-provisioning" {
#  content         = yamlencode(module.provisioning-crawler)
#  filename        = "${path.cwd}/../crawler_ssh_cmd.sh"
#  file_permission = 0644
#}

# ------------------------------
# GOD-HAND用のインスタンス作成
# ------------------------------

module "provisioning-god-hand" {
  source = "../ec2/provisioning/god-hand"
  depends_on = [
    module.god-hand,
    local_file.god-hand_ssh_config,
    local_file.god_my_cnf,
    local_file.site-info_my_cnf,
  ]
  instance_id    = module.god-hand.god-hand_id
  dir_appconfig  = "${local.appconfig}/etc"
  dir_public_key = local.public_key
  ssh = {
    config = "${local.appconfig}/etc/ssh/god-hand/config"
    host   = "auto.${local.host-ssh-god-hand}"
  }
}

# -----------------------------------
# GOD-HAND用のローカルファイル作成
# -----------------------------------

resource "local_file" "god-hand-provisioning" {
  content         = yamlencode(module.provisioning-god-hand)
  filename        = "${path.cwd}/../god-hand_ssh_cmd.sh"
  file_permission = 0644
}
