terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "hmanzursoft"

    workspaces {
      name = "2021-proeficient---challenge-demo"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}