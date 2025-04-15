locals {
  # Automatically load account-level variables
  account_vars = read_terragrunt_config(find_in_parent_folders("account.hcl"))
  # Automatically load environment-level variables
  region_vars = read_terragrunt_config(find_in_parent_folders("region.hcl"))

  # Extract out common variables for reuse
  aws_region = local.region_vars.locals.aws_region
}

terraform {
  source = "/home/bautista/Desktop/general/n1co/sandbox/pod-identity-association/module"

}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

dependency "vpc" {
  config_path = "../../vpc"
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# ---------------------------------------------------------------------------------------------------------------------

inputs = {
  region                          = local.aws_region
  cluster_name                    = "n1co-cross"
  iam_role_name_postfix           = "loki-role"
  description                     = "Role para que Loki pueda hacer push a S3"

  # Política custom en línea (como antes)
  custom_policies_json = [
    jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Sid    = "S3Policies"
          Effect = "Allow"
          Action = [
            "s3:PutObject",
            "s3:ListBucket",
            "s3:GetObject",
            "s3:DeleteObject"
          ]
          Resource = [
            "arn:aws:s3:::sidom-cross-loki-k8s-logs",
            "arn:aws:s3:::sidom-cross-loki-k8s-logs/*"
          ]
        }
      ]
    })
  ]

  # Association con SA
  namespace_service_accounts = [
    {
      namespace       = "loki"
      service_account = "loki"
    }
  ]

  tags = {
    environment = "cross"
    owner       = "observability"
  }
}