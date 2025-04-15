
terraform {
  required_version = ">= 1.5.5"

  # This module has been updated for helm v3 usage. We do not recommend using this version with helm v2.
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.72"
    }
  }
}

# ----------------------------------------------------------------------------------------------------------------------
# Locals
# ----------------------------------------------------------------------------------------------------------------------

locals {
  roles_json = jsondecode(file(var.path_to_roles_json))

  formatted_managed_policies = {
    for idx, entry in flatten([
      for role in local.roles_json : [
        for policy_arn in lookup(role, "aws_managed_policy_arns", []) : {
          role       = role.name
          policy_arn = policy_arn
        }
      ]
    ]) :
    "${entry.role}-${idx}" => {
      role       = entry.role
      policy_arn = entry.policy_arn
    }
  }

  # custom_policies = flatten([ 
  #   for role in local.roles_json : 
  #   [ 
  #     for policy in role.custom_policies : 
  #     { 
  #       (role.name) = policy
  #     }
  #   ]
  #   if lookup(role, "custom_policies", "") != ""
  # ])

  formatted_custom_policies = {
    for idx, role in flatten([
      for role in local.roles_json : [
        for policy in lookup(role, "custom_policies", []) : {
          role   = role.name
          policy = policy
        }
      ] 
    ]) :
    "${role.role}-${idx}" => {
      role   = role.role
      policy = role.policy
      idx    = idx
    }
  }
}

# ----------------------------------------------------------------------------------------------------------------------
# IAM Role
# ----------------------------------------------------------------------------------------------------------------------

resource "aws_iam_role" "this" {
  for_each            = { 
    for idx, role in local.roles_json : role.name => role
  }

  name                = each.value.name
  description         = lookup(each.value, "description", "")
  assume_role_policy  = data.aws_iam_policy_document.this.json
  
  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}

data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "aws_eks_pod_identity_association" "pod_identity_association" {
  for_each        = {
    for idx, role in local.roles_json : role.name => role
  }

  cluster_name    = var.cluster_name
  namespace       = each.value.namespace
  service_account = each.value.service_account
  role_arn        = aws_iam_role.this[each.value.name].arn
}

# ----------------------------------------------------------------------------------------------------------------------
# IAM policies
# ----------------------------------------------------------------------------------------------------------------------

resource "aws_iam_policy" "custom_policy" {
  for_each = local.formatted_custom_policies

  name     = "${each.value.role}-${each.value.idx}"
  policy   = jsonencode(each.value.policy)
  tags     = var.tags
}

resource "aws_iam_role_policy_attachment" "custom_policy" {
  for_each = local.formatted_custom_policies

  role       = each.value.role
  policy_arn = aws_iam_policy.custom_policy[each.key].arn

  depends_on = [aws_iam_role.this]
}

resource "aws_iam_role_policy_attachment" "managed_policy" {
  for_each   = local.formatted_managed_policies

  role       = each.value.role
  policy_arn = each.value.policy_arn

  depends_on = [aws_iam_role.this]
}