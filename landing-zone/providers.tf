terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.36.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  # credentials come from the GitHub Actions role
}
