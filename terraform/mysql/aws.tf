data "aws_caller_identity" "current" {}

locals {
  project     = "media-wiki"
  name_prefix = "media-wiki"
  region      = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "media-wiki-tfstate-backup"
    dynamodb_table = "media-wiki-terraform-state-lock-dynamodb"
    encrypt        = true
    key            = "media-wiki/mysql.tfstate"
    region         = "us-east-1"
  }
}

provider "aws" {
  region  = "us-east-1"
  version = "~> 2.40"
}