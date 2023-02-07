variable "name" {}
variable "fqdn" {}
variable "key_name" {}
variable "subnet_id" {}
variable "security_groups" {}
variable "ami" {}
variable "type" { default = "t3.nano" }
variable "size" { default = "8" }
variable "profile" {}
variable "aws_profile" {}

module "crawler-ubuntu" {
  source       = "../../env-ec2"
  new_hostname = var.fqdn
}


resource "local_file" "crawler-raw" {
  filename        = "${path.cwd}/crawler_output.sh"
  file_permission = "0755"
  content         = module.crawler-ubuntu.raw
}


resource "aws_instance" "crawler" {
  ami                     = var.ami
  instance_type           = var.type
  key_name                = var.key_name
  subnet_id               = var.subnet_id
  vpc_security_group_ids  = var.security_groups
  disable_api_termination = false
  root_block_device {
    volume_type           = "gp3"
    volume_size           = var.size
    delete_on_termination = true
  }

  tags = {
    Name = var.name
  }

  credit_specification {
    cpu_credits = "unlimited"
  }
  iam_instance_profile = var.profile
  user_data            = module.crawler-ubuntu.user_data
}

output "crawler_id" {
  value = aws_instance.crawler.id
}

output "crawler_ami" {
  value = aws_instance.crawler.ami
}

output "crawler_private_ip" {
  value = aws_instance.crawler.private_ip
}

output "crawler_availability_zone" {
  value = aws_instance.crawler.availability_zone
}

output "crawler_instance_type" {
  value = aws_instance.crawler.instance_type
}

output "crawler_root_volume_size" {
  value = aws_instance.crawler.root_block_device[0].volume_size
}

output "crawler_name" {
  value = aws_instance.crawler.tags.Name
}
