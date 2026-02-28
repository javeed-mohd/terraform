terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.33.0" # TERRAFORM AWS Provider Version
    }
  }
}

provider "aws" {
  region = "us-east-1" # Configuration options
}