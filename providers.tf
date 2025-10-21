terraform {
  required_version = ">= 1.6.6"

  # backend "s3" {
  #   # Modify bucket/region/key to point to the S3 bucket you want to use for storing your Terraform state. This bucket
  #   # must already exist in the AWS account you're deploying to
  #   bucket         = "my-bucket"
  #   region         = "us-west-2"
  #   key            = "myproject/terraform.tfstate"

  #   use_lockfile   = true
  # }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.22"
    }
  }
}
