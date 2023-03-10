# AWSコンソール / AWS-CLIの設定について
## AWSコンソールにサインインするための手順

事前にスマートフォンなどに「Google Authenticator([iOS](https://apps.apple.com/jp/app/google-authenticator/id388497605) / [Android](https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2&hl=ja&gl=US))」などの多段認証ツールを導入してください。

[Bitwarden](https://go.bitwarden.com/jp/password-management-for-business-teams-organizations/) Premiumでも利用可能ですが、ここではGoogle Authenticatorを例に説明します。

1. ご連絡させていただいた情報でサインインしてください
2. サインイン後にパスワードの変更を求められますので、任意のパスワードに変更してください。
3. 右上のユーザ名のあるプルダウンから、「セキュリティー認証情報」を選択してください。
4. 多要素認証（MFA）の「MFAデバイスの割り当て」を押して下さい。(デバイス名はユーザ名を設定する)
5. 「仮想MFAデバイス」→「QRコードの表示」を押して下さい。
6. Google Authenticatorを起動し、＋を押してQRコードをスキャンしてください。
7. MFAコードが登録されますので、2回続けてMFAコードを入力します。
8. 登録が完了したら、右上のユーザ名のあるプルダウンから、「サインアウト」を行います。
9. 再度サインインを行って、サインインできることを確認してください。

## アクセスキーペアの取得方法

1. AWSコンソールにサインインしてください。
2. 右上のユーザ名のあるプルダウンから、「セキュリティー認証情報」を選択してください。
3. 「アクセスキーの作成」を押して下さい。
4. アクセスキーIDとシークレットアクセスキーをメモしてください。  
  
csvダウンロードしておくと失念しても手間が少ないです。  
  

## AWSCLIのインストールと初期設定

[こちらのサイト](https://aws.amazon.com/jp/cli/)を参考にして、awscliを導入してください。

初期設定
  
## MAC  
  
プロファイル付きで設定を行います。以下を参考に設定してください。
プロファイル名は任意に決めて下さい。おすすめはアカウントエイリアス名です。
ここではexampleとしてあります。

	$ aws configure --profile=example
	AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
	AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
	Default region name [None]: ap-northeast-1
	Default output format [None]:
  

プロファイル付きで設定した場合、環境変数を設定することで、そのプロファイルが利用できるようになります。

	$ export AWS_DEFAULT_PROFILE=example

以下のコマンドが実行できれば、設定できています。

	$ aws sts get-caller-identity
	{
	    "UserId": "AKIAIOSFODNN7EXAMPLE",
	    "Account": "123456789012",
	    "Arn": "arn:aws:iam::123456789012:user/userid"
	}

アクセスキーを用いたMFA認証の実行
  
  


アクセスキーを使用した場合でも、MFAの認証が必要になります。 現在のアクセスキーを利用してMFA認証を行い、それが有効なセッションのアクセスキーを発行されるので、それを利用するという仕組みになります。 手作業で行うととても煩雑です。以下にサンプルを用意しましたので適宜実行ください。

[config_ssh.sh](https://github.com/FrankArt/gem-god-infra/blob/4d45db4e87cb3d53c650394be551958864255360/appconfig/config_ssh.sh)

gem-god-backend_mfaというプロファイルが作成されますので、以下コマンドにてプロファイルに反映してください。

export AWS_PROFILE=********

	$ aws s3 ls

などを実行して Access Denied がでなければ成功です。

## Windows

 アクセスキーを使用した場合でも、MFAの認証が必要になります。 現在のアクセスキーを利用してMFA認証を行い、それが有効なセッションのアクセスキーを発行されるので>    、それを利用するという仕組みになります。 手作業で行うととても煩雑です。以下にサンプルを用意しましたので適宜実行ください。

1. C:\User\******> aws confiugre --profile gem-god-backend_mfa  
  
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE  
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY  
Default region name [None]: ap-northeast-1  
Default output format [None]:  
  
  
  
2. C:\User\******> aws sts get-caller-identity  
  
下記情報が取得が取得できない場合は、もう一度手順を見直してください。  
  
以下のコマンドが実行できれば、設定できています。  
  
$ aws sts get-caller-identity  
{  
    "UserId": "AKIAIOSFODNN7EXAMPLE",  
    "Account": "123456789012",  
    "Arn": "arn:aws:iam::123456789012:user/userid"  
}  
  
  
3. C:\User\******> [こちら](https://github.com/FrankArt/gem-god-infra/blob/main/appconfig/fadev/etc/windows_mfa_gettoken.bat)を取得してローカルの任意のフォルダに保管してください。ここでは「windows_mfa_gettoken.bat」としています  
  
  
4. C:\User\******> 8行目あたりの以下「*******」を自身のアカウント名に変更してください。  
  
--serial-number arn:arn:aws:iam::660506286494:user/*******  
  
5.保管したbatファイルを実行
  
C:\User\******> windows_mfa_gettoken.bat  
  
Refresh token? (y/n):y  
  
Please enter MFA One-Time-Password: 取得した６桁のトークンを入力
     
エラーが表示されず、以下のメッセージが表示されることを確認する  
  
Token has been set into environment variables. 
  
6. C:\User\******> aws s3 ls  
  
実行して S3のリストが表示されれば成功です。  
  
  


