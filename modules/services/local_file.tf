resource "local_file" "debug-god-api" {
  filename        = "${path.cwd}/../etc/debug-god-api.yaml"
  file_permission = 0600
  content = yamlencode({
    god-api     = module.god-api
    alb-god-api = module.alb-god-api
  })
}

resource "local_file" "debug-ec2-god-batch" {
  filename        = "${path.cwd}/../etc/debug-god-batch.yaml"
  file_permission = 0600
  content         = yamlencode(module.god-batch)
}

resource "local_file" "debug-ec2-god-crawler" {
  filename        = "${path.cwd}/../etc/debug-god-crawler.yaml"
  file_permission = 0600
  content         = yamlencode(module.god-crawler)
}


resource "local_file" "debug-god-hand" {
  filename        = "${path.cwd}/../etc/debug-god-hand.yaml"
  file_permission = 0600
  content = yamlencode({
    god-hand = module.god-hand
  })
}

resource "local_file" "debug-site-info-aurora-mysql" {
  filename        = "${path.cwd}/../etc/debug-site-info-aurora-mysql.yaml"
  file_permission = 0600
  content = yamlencode({
    cluster = module.site-info-aurora-mysql.cluster
    cluster = module.site-info-aurora-mysql.instance
  })
}

resource "local_file" "debug-god-aurora-mysql" {
  filename        = "${path.cwd}/../etc/debug-god-aurora-mysql.yaml"
  file_permission = 0600
  content = yamlencode({
    cluster  = module.god-aurora-mysql.cluster
    instance = module.god-aurora-mysql.instance
  })
}

resource "local_file" "debug-god-pre-aurora-mysql" {
  filename        = "${path.cwd}/../etc/debug-god-pre-aurora-mysql.yaml"
  file_permission = 0600
  content = yamlencode({
    cluster  = module.god-pre-aurora-mysql.cluster
    instance = module.god-pre-aurora-mysql.instance
  })
}

resource "local_file" "ssh_config" {
  filename        = "${local.appconfig}/etc/ssh/god-api/config"
  file_permission = 0644
  content         = <<EOF
  Host ${local.host-ssh-god-api}
	User ubuntu
  ProxyCommand sh -c "aws ssm start-session --profile '${var.aws_profile}' --target ${module.god-api.god-api_id} --region ap-northeast-1 --document-name AWS StartSSHSession --parameters 'PortNumber=%p'"

  Host auto.${local.host-ssh-god-api}
	User ubuntu
	StrictHostKeyChecking no
	UserKnownHostsFile ${local.appconfig}/etc/ssh/known_hosts
  ProxyCommand sh -c "aws ssm start-session --profile '${var.aws_profile}' --target ${module.god-api.god-api_id} --region ap-northeast-1 --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
EOF
}

resource "local_file" "god-batch_ssh_config" {
  filename        = "${local.appconfig}/etc/ssh/god-batch/config"
  file_permission = 0644
  content         = <<EOF
  Host ${local.host-ssh-god-batch}
	User Ubuntu
  ProxyCommand sh -c "aws ssm start-session --profile '${var.aws_profile}' --target ${module.god-batch.god-batch_id} --region ap-northeast-1 --document-name AWS StartSSHSession --parameters 'PortNumber=%p'"

  Host auto.${local.host-ssh-god-batch}
        User ubuntu
        StrictHostKeyChecking no
        UserKnownHostsFile ${local.appconfig}/etc/ssh/god-batch/known_hosts
  ProxyCommand sh -c "aws ssm start-session --profile '${var.aws_profile}' --target ${module.god-batch.god-batch_id} --region ap-northeast-1 --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
EOF
}

resource "local_file" "god-crawler_ssh_config" {
  filename        = "${local.appconfig}/etc/ssh/god-crawler/config"
  file_permission = 0644
  content         = <<EOF
  Host ${local.host-ssh-god-crawler}
        User Ubuntu
  ProxyCommand sh -c "aws ssm start-session --profile '${var.aws_profile}' --target ${module.god-crawler.god-crawler_id} --region ap-northeast-1 --document-name AWS StartSSHSession --parameters 'PortNumber=%p'"

  Host auto.${local.host-ssh-god-crawler}
        User ubuntu
        StrictHostKeyChecking no
        UserKnownHostsFile ${local.appconfig}/etc/ssh/god-crawler/known_hosts
  ProxyCommand sh -c "aws ssm start-session --profile '${var.aws_profile}' --target ${module.god-crawler.god-crawler_id} --region ap-northeast-1 --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
EOF
}

resource "local_file" "god-hand_ssh_config" {
  filename        = "${local.appconfig}/etc/ssh/god-hand/config"
  file_permission = 0644
  content         = <<EOF
  Host ${local.host-ssh-god-hand}
        User Ubuntu
  ProxyCommand sh -c "aws ssm start-session --profile '${var.aws_profile}' --target ${module.god-hand.god-hand_id} --region ap-northeast-1 --document-name AWS StartSSHSession --parameters 'PortNumber=%p'"

  Host auto.${local.host-ssh-god-hand}
        User ubuntu
        StrictHostKeyChecking no
        UserKnownHostsFile ${local.appconfig}/etc/ssh/god-hand/known_hosts
  ProxyCommand sh -c "aws ssm start-session --profile '${var.aws_profile}' --target ${module.god-hand.god-hand_id} --region ap-northeast-1 --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
EOF
}


resource "local_file" "ssh-god-api-cmd" {
  filename        = "${local.appconfig}/bin/ssh-god-api.sh"
  file_permission = 0755
  content         = <<EOS
#!/bin/bash
set -eu
exec ssh -F "${local.appconfig}/etc/ssh/god-api/config" ${local.host-ssh-god-api} $@
EOS
}


resource "local_file" "known_hosts" {
  filename        = "${local.appconfig}/etc/ssh/god-api/known_hosts"
  file_permission = 0644
  content         = ""
}
#resource "local_file" "mode_infra_yaml" {
#  filename        = "${local.appconfig}/etc/infra.yaml"
#  file_permission = "0644"
#  content = yamlencode({
#    db = {
#      master = {
#        host     = module.crawl-aurora-mysql.endpoint,
#        port     = module.crawl-aurora-mysql.port,
#        database = module.crawl-aurora-mysql.master.db,
#        username = module.crawl-aurora-mysql.api2.username,
#        password = module.crawl-aurora-mysql.api2.password,
#      },
#      fqdn = module.alb-api2.fqdns[0]
#    }
#  })
#}

resource "local_file" "site-info_my_cnf" {
  filename        = "${local.appconfig}/etc/site-info.my.cnf"
  file_permission = "0600"
  content         = <<EOF
[client]
host=${module.site-info-aurora-mysql.endpoint}
port=${module.site-info-aurora-mysql.port}
database=${module.site-info-aurora-mysql.site-info.db}
user=${module.site-info-aurora-mysql.site-info.username}
password=${module.site-info-aurora-mysql.site-info.password}
EOF
}

resource "local_file" "god_my_cnf" {
  filename        = "${local.appconfig}/etc/god.my.cnf"
  file_permission = "0600"
  content         = <<EOF
[client]
host=${module.god-aurora-mysql.endpoint}
port=${module.god-aurora-mysql.port}
database=${module.god-aurora-mysql.god.db}
user=${module.god-aurora-mysql.god.username}
password=${module.god-aurora-mysql.god.password}
EOF
}

resource "local_file" "god-pre_my_cnf" {
  filename        = "${local.appconfig}/etc/god-pre.my.cnf"
  file_permission = "0600"
  content         = <<EOF
[client]
host=${module.god-pre-aurora-mysql.endpoint}
port=${module.god-pre-aurora-mysql.port}
database=${module.god-pre-aurora-mysql.god-pre.db}
user=${module.god-pre-aurora-mysql.god-pre.username}
password=${module.god-pre-aurora-mysql.god-pre.password}
EOF
}

