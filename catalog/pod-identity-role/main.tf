# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Create a Pod Identity Role and his association
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

terraform {
  # compatible with TF 0.15.x code.
  required_version = ">= 1.0.0, <=1.5.5"
}

# ---------------------------------------------------------------------------------------------------------------------
# CONFIGURE OUR AWS CONNECTION
# ---------------------------------------------------------------------------------------------------------------------

provider "aws" {
  # The AWS region in which all resources will be created
  region = var.aws_region
}

module "pod_identity_role" {
  source = "/home/bautista/Desktop/general/n1co/sandbox/pod-identity-association/module/pod-identity-role"

  cluster_name               = var.cluster_name
  path_to_roles_json         = var.path_to_roles_json
  tags                       = var.tags
}
