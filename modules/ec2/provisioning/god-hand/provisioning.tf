variable "instance_id" {}
variable "ssh" {}
variable "dir_appconfig" {}
variable "dir_public_key" {}

locals {
  ssh_cmd = "ssh -F ${var.ssh.config} ${var.ssh.host}"
}

# 初期化完了まで待機する
resource "null_resource" "wait-for-init" {
  triggers = { instance_id = var.instance_id }
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    # SSHの接続を待機 → cloud-initを待機 → SSHの接続を待機(一度再起動するため)
    command = <<EOF
until ${local.ssh_cmd} true > /dev/null 2>&1 ; do echo "SSH接続待機中(1/2)"; sleep 1; done
${local.ssh_cmd} 'if [ -d /var/lib/cloud ]; then until [ -f /var/lib/cloud/instance/boot-finished ]; do echo "cloud-init待機中"; sleep 1; done; fi' || true
until ${local.ssh_cmd} true > /dev/null 2>&1 ; do echo "SSH接続待機中(2/2)"; sleep 1; done
EOF
  }
}

# 各種ファイルをPushする
resource "null_resource" "push-files" {
  triggers   = { instance_id = var.instance_id }
  depends_on = [null_resource.wait-for-init]
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command     = <<EOF
cat "${var.dir_appconfig}/composer.sh" | ${local.ssh_cmd} "cat > /tmp/composer.sh"
${local.ssh_cmd} "sudo chmod +x /tmp/composer.sh"
cat "${var.dir_appconfig}/site-info.my.cnf" | ${local.ssh_cmd} "cat > /home/ubuntu/.my.cnf"
${local.ssh_cmd} "chmod 600 /home/ubuntu/.my.cnf"
cat "${var.dir_appconfig}/site-info.my.cnf" | ${local.ssh_cmd} "cat > /home/ubuntu/.my.cnf"
${local.ssh_cmd} "chmod 600 /home/ubuntu/.my.cnf"

cat "${var.dir_appconfig}/god.my.cnf" | ${local.ssh_cmd} "cat > /home/ubuntu/.god.my.cnf"
${local.ssh_cmd} "chmod 600 /home/ubuntu/.god.my.cnf"
cat "${var.dir_public_key}/j-furuya-20230131.pub" | ${local.ssh_cmd} "cat >> /home/ubuntu/.ssh/authorized_keys"
cat "${var.dir_public_key}/t-okazaki-20230131.pub" | ${local.ssh_cmd} "cat >> /home/ubuntu/.ssh/authorized_keys"
EOF
  }
}

# nginxをインストールする
resource "null_resource" "nginx" {
  triggers   = { instance_id = var.instance_id }
  depends_on = [null_resource.push-files]
  provisioner "local-exec" {
    interpreter = ["ssh", "-F", var.ssh.config, var.ssh.host]
    command     = <<EOF
sudo apt install -y nginx
sudo touch /var/www/html/health_check.txt
sudo apt install -y php php-fpm php-common php-mysql php-gd php-cli php-mbstring
/tmp/composer.sh
sudo mv ./composer.phar $(dirname $(which php))/composer && chmod +x "$_"
composer --version
EOF
  }
}

# aws cliをインストールる
resource "null_resource" "awscli" {
  triggers   = { instance_id = var.instance_id }
  depends_on = [null_resource.nginx]
  provisioner "local-exec" {
    interpreter = ["ssh", "-F", var.ssh.config, var.ssh.host]
    command     = <<EOF
if [ -d /tmp/aws ]; then  
sudo rm -rf /tmp/aws
fi
sudo curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o /tmp/awscliv2.zip
sudo unzip /tmp/awscliv2.zip -d /tmp/ && sudo /tmp/aws/install -i /usr/local/aws-cli -b /usr/local/bin 
EOF
  }
}

# mysqlをインストールする
resource "null_resource" "mysqlclient" {
	triggers = { instance_id = var.instance_id }
	depends_on = [ null_resource.awscli ]
	provisioner "local-exec" {
		interpreter = ["ssh", "-F", var.ssh.config, var.ssh.host]
		command = <<EOF
export DEBIAN_FRONTEND=noninteractive
sudo apt-get install -y default-mysql-client
EOF
	}
}

output "dir_appconfig" {
  value = var.dir_appconfig
}

output "push-files" {
  value = null_resource.push-files
}

output "ssh_cmd" {
  value = local.ssh_cmd
}
output "instance_id" {
  value = var.instance_id
}
