terraform {
  required_version = ">= 1.6.6"

  backend "s3" {
    # Modify bucket and region to point to the S3 bucket you want to use for storing your Terraform state. This must
    # exist in the AWS account you're deploying to.
    bucket         = "my-bucket"
    region         = "us-west-2"

    key            = "terraform.tfstate"
    versioning     = true
    use_lockfile   = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.22"
    }
  }
}
