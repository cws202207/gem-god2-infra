variable "key_name" {}


module "another1" {
	source = "../dest2/"
	key_name = var.key_name
}

output "key_names" {
	value = var.key_name
}

resource "local_file" "key_name" {
	content = yamlencode(module.another1)
	filename = "${path.cwd}/another1.sh"
}
