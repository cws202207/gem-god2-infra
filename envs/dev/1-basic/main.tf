#terraform {
#  cloud {
#    organization = "gem-god-backend"
#
#    workspaces {
#      name = "dev-gem-god-backend-basic"
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
  key_name = "sou@gem-ed25519-20221205"
  public_key = file("../../../public-keys/sou-20221201.pub")
}

resource "aws_key_pair" "j-furuya" {
	key_name = "j-fuluya@gem-ed25519-20230131"
	public_key = file("../../../public-keys/j-furuya-20230131.pub")
}

resource "local_file" "type" {
	content = "fadev"
	filename = "${path.cwd}/../etc/awstype"
	file_permission = "0600"
}
resource  "local_file" "sou_key" {
	content = yamlencode(aws_key_pair.sou)
	filename = "${path.cwd}/../etc/sou_key.yaml"
	file_permission = "0600"
}

resource  "local_file" "j-furuya_key" {
	content = yamlencode(aws_key_pair.j-furuya)
	filename = "${path.cwd}/../etc/j-furuya_key.yaml"
	file_permission = "0600"
}

