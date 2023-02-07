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

module "god-api-ubuntu" {
	source = "../../env-ec2"
	new_hostname = var.fqdn
	}

resource "local_file" "god-api-raw" {
	filename = "${path.cwd}/god-api_output.sh"
	file_permission = "0755"
	content = module.god-api-ubuntu.raw
}

resource "aws_instance" "god-api" {
	ami = var.ami
	instance_type = var.type
	key_name = var.key_name
	subnet_id = var.subnet_id
	vpc_security_group_ids = var.security_groups
	disable_api_termination = false
	root_block_device {
		volume_type = "gp3"
		volume_size = var.size
		delete_on_termination = true
	}

	tags = {
		Name = var.name
}

	credit_specification {
		cpu_credits = "unlimited"
	}
	iam_instance_profile = var.profile
	user_data = module.god-api-ubuntu.user_data
}

output "god-api_id" {
	value = aws_instance.god-api.id
}

output "god-api_ami" {
	value = aws_instance.god-api.ami
}

output "god-api_private_ip" {
	value = aws_instance.god-api.private_ip
}

output "god-api_availability_zone" {
	value = aws_instance.god-api.availability_zone
}

output "god-api_instance_type" {
	value = aws_instance.god-api.instance_type
}

output "god-api_root_volume_size" {
	value = aws_instance.god-api.root_block_device[0].volume_size
}

output "god-api_name" {
	value = aws_instance.god-api.tags.Name
}

