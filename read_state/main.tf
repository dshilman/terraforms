
provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region

}
terraform {


  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "NYL"

    workspaces {
      name = "NYL-1"
    }
  }
}

resource "random_id" "random" {
  keepers = {
    uuid = uuid()
  }

  byte_length = 8
}

output "random" {
  value = random_id.random.hex
}

output "remote_state_server_public_ip" {
  value = data.terraform_remote_state.write_state.outputs.public_ip
}