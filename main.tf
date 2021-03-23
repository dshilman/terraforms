#
# DO NOT DELETE THESE LINES UNTIL INSTRUCTED TO!
#
# Your AMI ID is:
#
#     ami-056db1277deef2218
#
# Your subnet ID is:
#
#     subnet-0ed4f00267a2f569f
#
# Your VPC security group ID is:
#
#     sg-055ae0bd4eabf5e0b
#
# Your Identity is:
#
#     terraform-nyl-bison
#

provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region

}
module "keypair" {
  source  = "mitchellh/dynamic-keys/aws"
  version = "2.0.0"
  path    = "${path.root}/keys"
  name    = "${var.identity}.key"
}

module "server" {
  source = "./server"
  #count  = 2
  # server_os = "ubuntu"
  server_os              = var.server_os
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.subnet_id
  identity               = "terraform-nyl-ant"
  #key_name               = module.keypair.key_name
  private_key = module.keypair.private_key_pem
}


output "public_ip" {
  value = module.server.public_ip
}

output "public_dns" {
  value = module.server.public_dns
}

