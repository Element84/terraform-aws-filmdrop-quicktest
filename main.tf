locals {
  project_ident = "a1b2"
}

module "filmdrop" {
  # ==============================
  # Basic Usage
  # - Modify locals.project_ident above to a custom 4 char random string, to help identify your resources in AWS
  # - Modify filmdrop.source to point to your desired filmdrop terraform module location
  # - Modify infrastructure flags (deploy_*) to enable the components you want to deploy
  # ==============================

  # point to the source of filmdrop you're interested in testing
  #  - example: a local repo
  #      source  = "../filmdrop-aws-tf-modules"
  #  - example: reference a branch, tag, etc. (any value that "git checkout" supports)
  #      source  = "git::https://github.com/Element84/filmdrop-aws-tf-modules.git?ref=main"
  #      source  = "git::https://github.com/Element84/filmdrop-aws-tf-modules.git?ref=v2.55.0"
  source  = "git::https://github.com/Element84/filmdrop-aws-tf-modules.git?ref=main"

  # You may need to set this to your Route53 hosted zone for testing some components of FilmDrop, but for many its not
  # required/you can leave this as-is
  domain_zone            = ""

  # These can often be left as-is, but feel free to edit them. The local.project_ident string will be used to help
  # identify your project resources within the AWS account you're deploying to
  environment            = "test"
  project_name           = local.project_ident
  s3_access_log_bucket   = "fd-${local.project_ident}-test-quicktest-accesslogs"
  s3_logs_archive_bucket = "fd-${local.project_ident}-test-quicktest-logarch"

  # Infrastructure flags
  deploy_vpc                               = false
  deploy_vpc_search                        = true
  deploy_log_archive                       = false
  deploy_stac_server_opensearch_serverless = false
  deploy_stac_server                       = false
  deploy_stac_server_outside_vpc           = false
  deploy_analytics                         = false
  deploy_titiler                           = false
  deploy_console_ui                        = false
  deploy_cirrus                            = false
  deploy_cirrus_dashboard                  = false
  deploy_local_stac_server_artifacts       = false
  deploy_waf_rule                          = false

  # ==============================
  # Cirrus Testing
  # ==============================
}
