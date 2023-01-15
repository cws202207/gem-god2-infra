# AWSプロファイル
# mfa.shを実行して、mfaを有効にしておく

locals {
	aws_profile = "gem-entertainment-standard-fa-dev_mfa"

terraform {
  cloud {
    organization = "gem-entertainment-standard"

    workspaces {
      name = "gem-es2-fadev-shared"

    }
  }
}

locals {
	aws_profile = "gem-entertainment-standard-fa-dev_mfa"
}

module "build-ami" {
	source = "../../../modules/ec2/build-ami"
	key_name = "sou@ed25519-20221201_company"
	instance_profile = "StandardInstanceProfile"
#	aws_profile = local.aws_profile
}

target = {
	arch = "amd64",
	os = "debian",
	version = "10"
}

output "build-ami" {
	value = module.build.ami
}
