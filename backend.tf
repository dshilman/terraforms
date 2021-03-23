terraform {
  backend "remote" {
    organization = "NYL"

    workspaces {
      name = "NYL-1"
    }
  }
}