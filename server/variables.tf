variable "server_os" {}
variable "subnet_id" {}
variable "vpc_security_group_ids" {
  type = list(any)
}
variable "identity" {}
variable private_key {}
variable num_webs {
  default = "1"
}

#variable "access_key" {}

variable "region" {
  default = "us-east-1"
}
#variable "ami" {}