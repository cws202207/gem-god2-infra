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

module "unity-ubuntu" {
	source = "../../env-ec2"
	new_hostname = var.fqdn
	}

resource "local_file" "unity-raw" {
	filename = "${path.cwd}/unity_output.sh"
	file_permission = "0755"
	content = module.unity-ubuntu.raw
}

resource "aws_instance" "unity" {
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
	user_data = module.unity-ubuntu.user_data
}

output "unity_id" {
	value = aws_instance.unity.id
}

output "unity_ami" {
	value = aws_instance.unity.ami
}

output "unity_private_ip" {
	value = aws_instance.unity.private_ip
}

output "unity_availability_zone" {
	value = aws_instance.unity.availability_zone
}

output "unity_instance_type" {
	value = aws_instance.unity.instance_type
}

output "unity_root_volume_size" {
	value = aws_instance.unity.root_block_device[0].volume_size
}

output "unity_name" {
	value = aws_instance.unity.tags.Name
}

