provider "aws" {
  region = var.region # Main region
}
# Repository when save state file
terraform {
  backend "s3" {
    bucket = "terraform-state-tk"
    key = "global/s3/ec2docker/terraform.tfstate"
    region = "eu-central-1"
  }
}
