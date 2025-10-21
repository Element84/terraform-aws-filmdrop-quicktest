terraform {
  required_version = ">= 1.6.6"

  backend "s3" {
    # Modify bucket/region/keyto point to the S3 bucket you want to use for storing your Terraform state. This bucket
    # must already exist in the AWS account you're deploying to
    bucket         = "fd-jai-tf-state-91733293"
    region         = "us-west-2"
    key            = "lambdareqs/terraform.tfstate"

    use_lockfile   = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.22"
    }
  }
}
