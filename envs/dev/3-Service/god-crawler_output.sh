#!/bin/bash
set -eu

# 新しいホスト名
NEW_HOSTNAME="god-crawler.gem-god-backend.com"

# SSM-Agentの設定
install_ssm_agent() {
	local region=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone | sed -e 's/.$//')
	local arch
	case "$(uname -m)" in
		"x86_64"  ) arch="debian_amd64" ;;
		"aarch64" ) arch="debian_arm64" ;;
		* ) echo "Unknown Arch."; exit 1 ;;
	esac
	local url="https://s3.$region.amazonaws.com/amazon-ssm-$region/latest/$arch/amazon-ssm-agent.deb"
	mkdir /tmp/ssm
	cd /tmp/ssm
	wget $url
	sudo dpkg -i amazon-ssm-agent.deb
	sudo systemctl enable amazon-ssm-agent
	sudo systemctl status amazon-ssm-agent
	cd /
	rm -rf /tmp/ssm
}

# 基本的なツールの設定
install_basic() {
	sudo sh << 'EOS'
export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get -y install \
    tzdata \
    git \
    curl \
    wget \
    vim \
    ntp \
    postfix \
    jq \
    unzip \
    sudo \
    dnsutils \
	lsb-release \
	build-essential
EOS

	# Timezone設定
	sudo rm /etc/localtime
	sudo ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
	sudo sh -c "echo 'Asia/Tokyo' > /etc/timezone"
	date

	# vim設定
	sudo sh -c 'cat > /etc/vim/vimrc.local' << 'EOS'
syntax on
set wildmenu
set history=100
set number
set scrolloff=5
set autowrite
set tabstop=4
set shiftwidth=4
set softtabstop=0
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,cp932,euc-jp,iso-2022-jp,ucs2le,ucs-2
set fenc=utf-8
set enc=utf-8
EOS

	# ntp設定
	sudo update-alternatives --set editor /usr/bin/vim.basic
	sudo mv /etc/ntp.conf /etc/ntp.conf.orig

	sudo sh -c 'cat > /etc/ntp.conf' << 'EOS'
driftfile /var/lib/ntp/drift
statistics loopstats peerstats clockstats
filegen loopstats file loopstats type day enable
filegen peerstats file peerstats type day enable
filegen clockstats file clockstats type day enable

restrict -4 default kod notrap nomodify nopeer noquery
restrict -6 default kod nomodify notrap nopeer noquery
restrict 127.0.0.1 
restrict ::1

server 0.amazon.pool.ntp.org iburst
server 1.amazon.pool.ntp.org iburst
server 2.amazon.pool.ntp.org iburst
server 3.amazon.pool.ntp.org iburst
EOS

	sudo service ntp restart
	sleep 10
	sudo ntpq -p

	# Postfix設定
	# 設定はするが停止しておく
	sudo sed -i.bak -e 's/^\(inet_protocols = all\)/#\1/' /etc/postfix/main.cf
	sudo sh -c "echo 'inet_protocols = ipv4' >> /etc/postfix/main.cf"
	sudo systemctl stop postfix
	sudo systemctl disable postfix

	# adminのプロンプト
	echo 'export PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\H\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "' >> /home/ubuntu/.bashrc
}

# 新しいホスト名の設定
set_hostname() {
	sudo sed -i -e 's/preserve_hostname: false/preserve_hostname: true/' /etc/cloud/cloud.cfg
	sudo sed -i -e "s/127.0.0.1 localhost/127.0.0.1 localhost $NEW_HOSTNAME/" /etc/cloud/templates/hosts.debian.tmpl
	sudo hostnamectl set-hostname $NEW_HOSTNAME
}

# install_ssm_agent
install_basic
set_hostname
sudo reboot
