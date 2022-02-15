terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

/* backend "s3" {
        bucket  = "prod-james-devsecops"
        key     = "terraform/create-bucket-s3/prod-james-s3.tfstate"
        region  = var.region
    }
} */