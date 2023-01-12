resource "local_file" "debug-ec2-api2" {
  filename        = "${path.cwd}/../etc/debug-ec2-api.yaml"
  file_permission = 0600
  content = yamlencode({
    ec2-api2 = module.ec2-api2
    alb-api  = module.alb-api2
  })
}

resource "local_file" "debug-ec2-mgmt" {
  filename        = "${path.cwd}/../etc/debug-ec2-mgmt.yaml"
  file_permission = 0600
  content = yamlencode({
    ec2-mgmt = module.ec2-mgmt
  })
}

resource "local_file" "debug-ec2-crawler" {
  filename        = "${path.cwd}/../etc/debug-ec2-crawler.yaml"
  file_permission = 0600
  content = yamlencode({
    ec2-crawler = module.ec2-crawler
  })
}

resource "local_file" "debug-ec2-unity" {
	filename = "${path.cwd}/../etc/debug-ec2-unity.yaml"
	file_permission = 0600
	content = yamlencode({
		ec2-unity = module.ec2-unity
	})
}

resource "local_file" "debug-crawler-aurora-mysql" {
  filename        = "${path.cwd}/../etc/debug-crawl_data-aurora-mysql.yaml"
  file_permission = 0600
  content = yamlencode({
    cluster = module.crawl-aurora-mysql.cluster
    cluster = module.crawl-aurora-mysql.instance
  })
}

resource "local_file" "debug-ipmaster-aurora-mysql" {
  filename        = "${path.cwd}/../etc/debug-ip_master-aurora-mysql.yaml"
  file_permission = 0600
  content = yamlencode({
    cluster  = module.ip-master.cluster
    instance = module.ip-master.instance
  })
}


resource "local_file" "ssh_config" {
  filename        = "${local.appconfig}/etc/ssh/config"
  file_permission = 0644
  content         = <<EOF
  Host ${local.host-ssh-api2}
	User ubuntu
  ProxyCommand sh -c "aws ssm start-session --profile '${var.aws_profile}' --target ${module.ec2-api2.api2_id} --region ap-northeast-1 --document-name AWS StartSSHSession --parameters 'PortNumber=%p'"

  Host auto.${local.host-ssh-api2}
	User ubuntu
	StrictHostKeyChecking no
	UserKnownHostsFile ${local.appconfig}/etc/ssh/known_hosts
  ProxyCommand sh -c "aws ssm start-session --profile '${var.aws_profile}' --target ${module.ec2-api2.api2_id} --region ap-northeast-1 --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
EOF
}

resource "local_file" "mgmt_ssh_config" {
  filename        = "${local.appconfig}/etc/ssh/mgmt/config"
  file_permission = 0644
  content         = <<EOF
  Host ${local.host-ssh-mgmt}
	User Ubuntu
  ProxyCommand sh -c "aws ssm start-session --profile '${var.aws_profile}' --target ${module.ec2-mgmt.mgmt_id} --region ap-northeast-1 --document-name AWS StartSSHSession --parameters 'PortNumber=%p'"

  Host auto.${local.host-ssh-mgmt}
        User ubuntu
        StrictHostKeyChecking no
        UserKnownHostsFile ${local.appconfig}/etc/ssh/mgmt/known_hosts
  ProxyCommand sh -c "aws ssm start-session --profile '${var.aws_profile}' --target ${module.ec2-mgmt.mgmt_id} --region ap-northeast-1 --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
EOF
}

resource "local_file" "crawler_ssh_config" {
  filename        = "${local.appconfig}/etc/ssh/crawler/config"
  file_permission = 0644
  content         = <<EOF
  Host ${local.host-ssh-crawler}
        User Ubuntu
  ProxyCommand sh -c "aws ssm start-session --profile '${var.aws_profile}' --target ${module.ec2-crawler.crawler_id} --region ap-northeast-1 --document-name AWS StartSSHSession --parameters 'PortNumber=%p'"

  Host auto.${local.host-ssh-crawler}
        User ubuntu
        StrictHostKeyChecking no
        UserKnownHostsFile ${local.appconfig}/etc/ssh/crawker/known_hosts
  ProxyCommand sh -c "aws ssm start-session --profile '${var.aws_profile}' --target ${module.ec2-crawler.crawler_id} --region ap-northeast-1 --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
EOF
}

resource "local_file" "unity_ssh_config" {
  filename        = "${local.appconfig}/etc/ssh/unity/config"
  file_permission = 0644
  content         = <<EOF
  Host ${local.host-ssh-unity}
        User Ubuntu
  ProxyCommand sh -c "aws ssm start-session --profile '${var.aws_profile}' --target ${module.ec2-unity.unity_id} --region ap-northeast-1 --document-name AWS StartSSHSession --parameters 'PortNumber=%p'"

  Host auto.${local.host-ssh-unity}
        User ubuntu
        StrictHostKeyChecking no
        UserKnownHostsFile ${local.appconfig}/etc/ssh/unity/known_hosts
  ProxyCommand sh -c "aws ssm start-session --profile '${var.aws_profile}' --target ${module.ec2-unity.unity_id} --region ap-northeast-1 --document-name AWS-StartSSHSession --parameters 'portNumber=%p'"
EOF
}


resource "local_file" "ssh-api-cmd" {
  filename        = "${local.appconfig}/bin/ssh-api2.sh"
  file_permission = 0755
  content         = <<EOS
#!/bin/bash
set -eu
exec ssh -F "${local.appconfig}/etc/ssh/config" ${local.host-ssh-api2} $@
EOS
}


resource "local_file" "known_hosts" {
  filename        = "${local.appconfig}/etc/ssh/known_hosts"
  file_permission = 0644
  content         = ""
}
resource "local_file" "mode_infra_yaml" {
  filename        = "${local.appconfig}/etc/infra.yaml"
  file_permission = "0644"
  content = yamlencode({
    db = {
      master = {
        host     = module.crawl-aurora-mysql.endpoint,
        port     = module.crawl-aurora-mysql.port,
        database = module.crawl-aurora-mysql.master.db,
        username = module.crawl-aurora-mysql.api2.username,
        password = module.crawl-aurora-mysql.api2.password,
      },
      fqdn = module.alb-api2.fqdns[0]
    }
  })
}

resource "local_file" "crawl-data_my_cnf" {
  filename        = "${local.appconfig}/etc/crawl-data.my.cnf"
  file_permission = "0600"
  content         = <<EOF
[client]
host=${module.crawl-aurora-mysql.endpoint}
port=${module.crawl-aurora-mysql.port}
database=${module.crawl-aurora-mysql.master.db}
user=${module.crawl-aurora-mysql.master.username}
password=${module.crawl-aurora-mysql.master.password}
EOF
}

resource "local_file" "ip-master_my_cnf" {
  filename        = "${local.appconfig}/etc/ip-master.my.cnf"
  file_permission = "0600"
  content         = <<EOF
[client]
host=${module.ip-master.endpoint}
port=${module.ip-master.port}
database=${module.ip-master.master.db}
user=${module.ip-master.master.username}
password=${module.ip-master.master.password}
EOF
}

resource "local_file" "pre-ip-master_my_cnf" {
  filename = "${local.appconfig}/etc/pre-ip-master.my.cnf"
  file_permission = "0600"
  content = <<EOF
[client]
host=${module.pre-ip-master.endpoint}
port=${module.pre-ip-master.port}
database=${module.pre-ip-master.pre-ip-master.db}
user=${module.pre-ip-master.pre-ip-master.username}
password=${module.pre-ip-master.pre-ip-master.password}
EOF
}


