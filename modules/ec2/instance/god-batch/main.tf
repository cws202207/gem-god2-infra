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

module "god-batch-ubuntu" {
	source = "../../env-ec2"
	new_hostname = var.fqdn
	}

resource "local_file" "god-batch-raw" {
	filename = "${path.cwd}/god-batch_output.sh"
	file_permission = "0755"
	content = module.god-batch-ubuntu.raw
}

resource "aws_instance" "god-batch" {
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
	user_data = module.god-batch-ubuntu.user_data
}

output "god-batch_id" {
	value = aws_instance.god-batch.id
}

output "god-batch_ami" {
	value = aws_instance.god-batch.ami
}

output "god-batch_private_ip" {
	value = aws_instance.god-batch.private_ip
}

output "god-batch_availability_zone" {
	value = aws_instance.god-batch.availability_zone
}

output "god-batch_instance_type" {
	value = aws_instance.god-batch.instance_type
}

output "god-batch_root_volume_size" {
	value = aws_instance.god-batch.root_block_device[0].volume_size
}

output "god-batch_name" {
	value = aws_instance.god-batch.tags.Name
}

