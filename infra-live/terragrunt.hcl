terraform {
  source = "/home/bautista/Desktop/general/n1co/sandbox/pod-identity-association/catalog/pod-identity-role"
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
# ---------------------------------------------------------------------------------------------------------------------

inputs = {
  aws_region                      = "us-east-2"
  cluster_name                    = "n1co-cross"
  path_to_roles_json              = "./roles/roles.json"

  tags = {
    environment = "cross"
    owner       = "monitoring"
  }
}