terraform {
  required_version = "= 0.11.14"

  # Backend contains hardcoded values to be properly initialized without additional complexity
  backend "s3" {
    bucket = "icevirm"
    key    = "terraform/public_ip_check/terraform.tfstate"
    region = "eu-west-1"
  }
}

provider "aws" {
  region  = "${var.region}"
  version = "~> 2.0"
}
