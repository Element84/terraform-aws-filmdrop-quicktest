# FilmDrop QuickTest

A simplified setup for testing FilmDrop Terraform on AWS. 

## Prereqs

- tfenv installed on your machine
- Optional: an S3 bucket, with versioning enabled, in the AWS account you'll be deploying to (this will be used to store your Terraform state). Uncomment the `backend` section of [providers.tf](./providers.tf) to use that S3 bucket for state storage. Without this, Terraform state is stored locally.

## Usage

1. Clone this repository, and create a branch for your testing.

2. Optional: uncomment and modify the `backend` section of [providers.tf](./providers.tf) to point to the S3 bucket you want to use for storing Terraform state. Without this, Terraform state is stored locally -- use caution.

3. Authenticate to the AWS account you're deploying to.

4. In [main.tf](./main.tf), follow the Basic Usage steps.
    
    4.1 Optionally, follow the custom steps for testing various FilmDrop components e.g. "Cirrus Testing" found throughout [main.tf](./main.tf).

5. Deploy your infrastructure!

```HCL
terraform init
terraform apply
```

## Contributing

PRs welcome! We'd love to add a wide variety of fully-functioning Cirrus feeders/tasks/workflows, FilmDrop UI configuration files, etc. See [CONTRIBUTING.md](./CONTRIBUTING.md) for details.
