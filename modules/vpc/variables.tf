
variable "vpc_cidr" {
  type    = string
  default = "172.33.0.0/16"
}

variable "azs" {
  type = map(object({
    public_cidr  = string
    private_cidr = string
  }))
  default = {
    a = {
      public_cidr  = "172.33.0.0/20"
      private_cidr = "172.33.48.0/20"
    },

    c = {
      public_cidr  = "172.33.16.0/20"
      private_cidr = "172.33.64.0/20"
    },

    d = {
      public_cidr  = "172.33.32.0/20"
      private_cidr = "172.33.80.0/20"
    }
  }
}

variable "enable_nat_gateway" {
  type    = bool
  default = true
}

variable "single_nat_gateway" {
  type    = bool
  default = true
}

