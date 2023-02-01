resource "local_file" "debug-god-api" {
  filename        = "${path.cwd}/../etc/debug-god-api.yaml"
  file_permission = 0600
  content = yamlencode({
    god-api     = module.god-api
    alb-god-api = module.alb-god-api
  })
}

# resource "local_file" "debug-ec2-mgmt" {
#  filename        = "${path.cwd}/../etc/debug-ec2-mgmt.yaml"
#  file_permission = 0600
#  content = yamlencode({
#    ec2-mgmt = module.ec2-mgmt
#  })
#}

#resource "local_file" "debug-ec2-crawler" {
#  filename        = "${path.cwd}/../etc/debug-ec2-crawler.yaml"
#  file_permission = 0600
#  content = yamlencode({
#    ec2-crawler = module.ec2-crawler
#  })
#}

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

# resource "local_file" "mgmt_ssh_config" {
#  filename        = "${local.appconfig}/etc/ssh/mgmt/config"
#  file_permission = 0644
#  content         = <<EOF
#  Host ${local.host-ssh-mgmt}
#	User Ubuntu
#  ProxyCommand sh -c "aws ssm start-session --profile '${var.aws_profile}' --target ${module.ec2-mgmt.mgmt_id} --region ap-northeast-1 --document-name AWS StartSSHSession --parameters 'PortNumber=%p'"
#
#  Host auto.${local.host-ssh-mgmt}
#        User ubuntu
#        StrictHostKeyChecking no
#        UserKnownHostsFile ${local.appconfig}/etc/ssh/mgmt/known_hosts
#  ProxyCommand sh -c "aws ssm start-session --profile '${var.aws_profile}' --target ${module.ec2-mgmt.mgmt_id} --region ap-northeast-1 --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
#EOF
#}

#resource "local_file" "crawler_ssh_config" {
#  filename        = "${local.appconfig}/etc/ssh/crawler/config"
#  file_permission = 0644
#  content         = <<EOF
#  Host ${local.host-ssh-crawler}
#        User Ubuntu
#  ProxyCommand sh -c "aws ssm start-session --profile '${var.aws_profile}' --target ${module.ec2-crawler.crawler_id} --region ap-northeast-1 --document-name AWS StartSSHSession --parameters 'PortNumber=%p'"
#
#  Host auto.${local.host-ssh-crawler}
#        User ubuntu
#        StrictHostKeyChecking no
#        UserKnownHostsFile ${local.appconfig}/etc/ssh/crawker/known_hosts
#  ProxyCommand sh -c "aws ssm start-session --profile '${var.aws_profile}' --target ${module.ec2-crawler.crawler_id} --region ap-northeast-1 --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
#EOF
#}

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

#resource "local_file" "pre-ip-master_my_cnf" {
#  filename = "${local.appconfig}/etc/pre-ip-master.my.cnf"
#  file_permission = "0600"
#  content = <<EOF
#[client]
#host=${module.pre-ip-master.endpoint}
#port=${module.pre-ip-master.port}
#database=${module.pre-ip-master.pre-ip-master.db}
#user=${module.pre-ip-master.pre-ip-master.username}
#password=${module.pre-ip-master.pre-ip-master.password}
#EOF
#}


