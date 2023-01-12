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

module "mgmt-ubuntu" {
	source = "../../env-ec2"
	new_hostname = var.fqdn
	}

resource "local_file" "mgmt-raw" {
	filename = "${path.cwd}/mgmt_output.sh"
	file_permission = "0755"
	content = module.mgmt-ubuntu.raw
}

resource "aws_instance" "mgmt" {
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
	user_data = module.mgmt-ubuntu.user_data
}

output "mgmt_id" {
	value = aws_instance.mgmt.id
}

output "mgmt_ami" {
	value = aws_instance.mgmt.ami
}

output "mgmt_private_ip" {
	value = aws_instance.mgmt.private_ip
}

output "mgmt_availability_zone" {
	value = aws_instance.mgmt.availability_zone
}

output "mgmt_instance_type" {
	value = aws_instance.mgmt.instance_type
}

output "mgmt_root_volume_size" {
	value = aws_instance.mgmt.root_block_device[0].volume_size
}

output "mgmt_name" {
	value = aws_instance.mgmt.tags.Name
}

