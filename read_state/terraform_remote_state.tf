data "terraform_remote_state" "write_state" {
  backend = "remote"

  config = {
    hostname     = "app.terraform.io"
    organization = "NYL"

    workspaces = {
      name = "NYL-1"
    }
  }
}
