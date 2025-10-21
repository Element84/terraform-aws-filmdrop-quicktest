locals {
  project_ident = "a1b2"
}

module "filmdrop" {
  # ==============================
  # Basic Usage
  #
  # - Modify locals.project_ident above to a custom 4 char random string, to help identify your resources in AWS
  # - Modify filmdrop.source to point to your desired filmdrop terraform module location
  # - Modify infrastructure flags (deploy_*) to enable the components you want to deploy
  # ==============================

  # Point to the source of filmdrop you're interested in testing
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
  deploy_vpc_search                        = true
  deploy_cirrus                            = false
  deploy_cirrus_dashboard                  = false
  deploy_stac_server_opensearch_serverless = false
  deploy_stac_server                       = false
  deploy_stac_server_outside_vpc           = false
  deploy_titiler                           = false
  deploy_console_ui                        = false
  deploy_local_stac_server_artifacts       = false
  deploy_waf_rule                          = false
  deploy_analytics                         = false
  deploy_vpc                               = false
  deploy_log_archive                       = false

  # ==============================
  # Cirrus Testing
  #
  # To test Cirrus Workflows:
  # - Set deploy_cirrus = true above
  # - Uncomment cirrus_inputs below. Selectively uncomment the _definitions_dirs you want to use.
  # - Paste your feeders/workflows/tasks into the /cirrus folder at the root of this repo. Note
  #   that /cirrus-examples contains some starting points.
  # ==============================
  # cirrus_inputs = {
  #   # feeder_definitions_dir                       = "cirrus/feeders"
  #   # workflow_definitions_dir                     = "cirrus/workflows"
  #   # task_definitions_dir                         = "cirrus/tasks"
  #   # task_batch_compute_definitions_dir           = "cirrus/tasks-batch"

  #   workflow_definitions_variables               = null
  #   workflow_definitions_variables_ssm           = null
  #   task_batch_compute_definitions_variables     = null
  #   task_batch_compute_definitions_variables_ssm = null
  #   task_definitions_variables                   = null
  #   task_definitions_variables_ssm               = null

  #   data_bucket                               = "" # If left blank the deployment will create the data bucket
  #   payload_bucket                            = "" # If left blank the deployment will create the payload bucket
  #   log_level                                 = "DEBUG"
  #   deploy_alarms                             = true
  #   api_rest_type                             = "EDGE"
  #   private_api_additional_security_group_ids = null
  #   private_certificate_arn                   = ""
  #   domain_alias                              = ""
  #   custom_alarms = {
  #     warning  = {}
  #     critical = {}
  #   }
  #   process = {
  #     sqs_timeout                   = 180
  #     sqs_max_receive_count         = 5
  #     sqs_cross_account_sender_arns = []
  #   }
  #   state = {
  #     timestream_magnetic_store_retention_period_in_days = 93
  #     timestream_memory_store_retention_period_in_hours  = 24
  #   }
  #   api_lambda = {
  #     timeout = 10
  #     memory  = 512
  #   }
  #   process_lambda = {
  #     timeout              = 10
  #     memory               = 512
  #     reserved_concurrency = 16
  #   }
  #   update_state_lambda = {
  #     timeout = 15
  #     memory  = 512
  #   }
  #   pre_batch_lambda = {
  #     timeout = 15
  #     memory  = 512
  #   }
  #   post_batch_lambda = {
  #     timeout = 15
  #     memory  = 512
  #   }
  # }
}
