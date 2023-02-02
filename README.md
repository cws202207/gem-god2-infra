# gem-god-infra

gem-god-backend.comインフラ構成サンプル

# 大枠の流れ

1. AWSアカウントの開設
2. 作業者・開発者のIAM作成
3. [env/[AWS環境名]/1-Basic](env/dev/1-Basic) の適用
4. DNSの委譲・割当
5. [env/[AWS環境名]/2-VPC](env/dev/2-VPC) の適用
7. [env/[AWS環境名]/3-Services](env/dev/3-Services) の適用

# 実行前の注意点

* 実行前にMFA認証を通過しておくこと
* ssh-agentにSSH秘密鍵を読み込んでおくこと


# 構築情報
Ubuntu 20.04.5 LTS  
  
PHP 7.4.3  
  
Composer 2.5.1  
  
mysql  Ver 8.0.32  
  
以下、特記のないものは、fadev環境の例

## AWS情報

* Aurora MySQLなどの接続情報は EC2インスタンスのgod-api / god-hand / god-batchのカレントディレクトリに保存されている

### データベース情報

* god-batch / god-hand  
.cnf : ~/.god-pre.my.cnf  
port : 3306  
database : god_pre  
user : god_pre  
password : ~/.god-pre.my.cnfに記載  
  
* god-api / god-hand
.cnf : ~/.god.my.cnf  
port : 3306  
database : god  
user : god  
password : ~/.god.my.cnfに記載  

* god-crawler  
.cnf : ~/.my.cnf  
port : 3306  
database : site_info  
user : site_info  
password : ~/.my.cnfに記載  
  
### インスタンス情報
### SSH接続
  
* [god-api](https://github.com/FrankArt/gem-god-infra/blob/main/appconfig/fadev/etc/ssh/god-api/config)にシェルスクリプトが生成されるので、それを実行すればログインできる。
  
* [god-hand](https://github.com/FrankArt/gem-god-infra/blob/main/appconfig/fadev/etc/ssh/god-hand/config)にシェルスクリプトが生成されるので、それを実行すればログインできる。
  
* [god-batch](https://github.com/FrankArt/gem-god-infra/blob/main/appconfig/fadev/etc/ssh/god-batch/config)にシェルスクリプトが生成されるので、それを実行すればログインでき>る。

カレントディレクトリなどに任意の名前で上記スクリプトを保存

* god-api    → $ ssh -F [god-api] auto.dev.god-api.fadev
* god-hand   → $ ssh -F [god-hand] auto.dev.god-api.fadev

### サーバの構成

* Ubuntu 20.04.5 LTS
* SSMエージェントなど基本的な設定が行われる。
* provisioningによってMySQLクライアント、phpなどがインストールされる
* ubuntuユーザは `mysql` と実行するだけで Aurora MySQLのsite_infoデータベースに接続することができる。
* ubuntuユーザは `mysql --defaults-file=.god.my.cnf` と実行するだけで Aurora MySQLのgodデータベースに接続することができる

