terraform {
  required_version = ">= 0.12.0"
  required_providers {
    aws = {
      version = "4.59.0"
      source  = "hashicorp/aws"
    }
    null = {
      version = "~> 3.1.1"
    }
    template = {
      version = "~> 2.2.0"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}