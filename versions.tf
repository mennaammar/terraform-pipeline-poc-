terraform {
  required_version = ">= 0.12.6"

  required_providers {
    #aws = ">= 3.24"
    aws = ">= 3.36"
  }
    backend "s3" {
      encrypt = true
      region = "us-east-1" #us-east-1
      bucket = "terraform-state-maf-poc-us-east" #terraform-state-maf-poc
      key = "terraform.tfstate"
    }
}
