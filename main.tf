terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

backend "s3" {
  bucket  = "james-devsecops"
  key     = var.tfStateFile
  region  = var.region
}