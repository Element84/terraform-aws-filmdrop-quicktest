locals {
  project_ident = "stcv"
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
  deploy_log_archive                       = true # required by numerous modules, recommend leaving as true
  deploy_cirrus                            = false
  deploy_cirrus_dashboard                  = false
  deploy_stac_server_opensearch_serverless = false
  deploy_stac_server                       = true
  deploy_stac_server_outside_vpc           = false
  deploy_titiler                           = false
  deploy_console_ui                        = false
  deploy_local_stac_server_artifacts       = false
  deploy_waf_rule                          = false
  deploy_analytics                         = false
  deploy_vpc                               = false

  #region Cirrus Testing
  # ==============================
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
  #endregion

  #region stac-server Testing
  # ==============================
  # To test stac-server:
  # - Set deploy_cirrus = true above
  # - Uncomment stac_server_inputs below
  # ==============================
  stac_server_inputs = {
    app_name                                    = "stac_server"
    version                                     = "v3.10.0"
    stac_id                                     = "stac-server"
    stac_title                                  = "STAC API"
    stac_title                                  = "A STAC API using stac-server"
    api_rest_type                               = "EDGE"
    api_method_authorization_type               = "NONE"
    deploy_cloudfront                           = true
    web_acl_id                                  = ""
    domain_alias                                = ""
    enable_transactions_extension               = false
    enable_collections_authx                    = false
    enable_filter_authx                         = false
    enable_response_compression                 = true
    items_max_limit                             = 100
    enable_ingest_action_truncate               = false
    collection_to_index_mappings                = ""
    opensearch_version                          = "OpenSearch_2.17"
    opensearch_cluster_instance_type            = "t3.small.search"
    opensearch_cluster_instance_count           = 3
    opensearch_cluster_dedicated_master_enabled = true
    opensearch_cluster_dedicated_master_type    = "t3.small.search"
    opensearch_cluster_dedicated_master_count   = 3
    opensearch_cluster_availability_zone_count  = 3
    opensearch_ebs_volume_size                  = 35
    ingest_sns_topic_arns                       = []
    additional_ingest_sqs_senders_arns          = []
    cors_origin                                 = "*"
    cors_credentials                            = false
    cors_methods                                = ""
    cors_headers                                = ""
    authorized_s3_arns                          = []
    private_api_additional_security_group_ids   = null
    api_lambda                                  = null
    ingest_lambda                               = null
    pre_hook_lambda                             = null
    private_certificate_arn                     = ""
    vpce_private_dns_enabled                    = false
    auth_function = {
      cf_function_name             = ""
      cf_function_runtime          = "cloudfront-js-2.0"
      cf_function_code_path        = ""
      attach_cf_function           = false
      cf_function_event_type       = "viewer-request"
      create_cf_function           = false
      create_cf_basicauth_function = false
      cf_function_arn              = ""
    }
    ingest = {
      source_catalog_url               = ""
      destination_collections_list     = ""
      destination_collections_min_lat  = -90
      destination_collections_min_long = -180
      destination_collections_max_lat  = 90
      destination_collections_max_long = 180
      date_start                       = ""
      date_end                         = ""
      include_historical_ingest        = false
      source_sns_arn                   = ""
      include_ongoing_ingest           = false
    }
  }
  #endregion
}
