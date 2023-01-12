variable "github_users" {
  default = []
}
variable "new_hostname" {}

locals {
  data = templatefile("${path.module}/userdata.tmpl.sh", {
    github_users = (length(var.github_users) == 0) ? "" : join(" ", var.github_users),
    new_hostname = var.new_hostname,
  })
}

output "user_data" {
  value = base64encode(local.data)
}

output "raw" {
  value = local.data
}

