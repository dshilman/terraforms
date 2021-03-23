variable "region" {
  default = "us-east-1"
}
variable "access_key" {
  sensitive = true
}
variable "secret_key" {
  sensitive = true
}

variable "server_os" {

}

variable "subnet_id" {

}

variable "identity" {

}

variable "vpc_security_group_ids" {
  type = list(any)
}