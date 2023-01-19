#terraform {
#  cloud {
#    organization = "gem-god-backend"
#
#    workspaces {
#      name = "gem-god-fadev-basic"
#
#    }
#  }
#}

terraform {
  backend "s3" {
    bucket = "gem-god-backend-fadev-basic-tfstate"
    key    = "gem/fadev/basic/main_v1.0.0.tfstate"
    region = "ap-northeast-1"
  }
}

data "aws_route53_zone" "z" {
  name         = "gem-god-backend.com."
  private_zone = false
}

# ドメイン
resource "local_file" "route53" {
  content = yamlencode({
    name : "gem-god-backend.com",
    zone_id : data.aws_route53_zone.z.id,
    name_servers : data.aws_route53_zone.z.name_servers,
  })
  filename        = "${path.cwd}/../etc/tf-route53.yaml"
  file_permission = "0600"
}

resource "aws_key_pair" "sou" {
  key_name = "sou@gem-ed25519-20221205_company_mac"
  public_key = file("../../../public-keys/sou-20221201.pub")
}


resource "local_file" "type" {
	content = "fadev"
	filename = "${path.cwd}/../etc/awstype"
	file_permission = "0600"
}
