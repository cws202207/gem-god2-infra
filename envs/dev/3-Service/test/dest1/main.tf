variable  "key_name" {
	default = {
       yoyogi =    "yoyogi"
       shinagawa =    "shinagawa"
  }  
}

module "another" {
  source   = "../src/"
  key_name = var.key_name
}

output "key_name" {
  value = module.another.key_names
}

