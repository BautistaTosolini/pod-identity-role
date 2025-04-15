
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
# IAM Role
# ----------------------------------------------------------------------------------------------------------------------

resource "aws_iam_role" "this" {
  count               = (length(var.aws_managed_policy_arns) + length(var.custom_policies_json) > 0) ? 1 : 0
  name                = "${var.cluster_name}-${var.iam_role_name_postfix}"
  assume_role_policy  = data.aws_iam_policy_document.this.json
  description         = var.description
  
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
  count           = length(var.namespace_service_accounts)
  cluster_name    = var.cluster_name
  namespace       = var.namespace_service_accounts[count.index].namespace
  service_account = var.namespace_service_accounts[count.index].service_account
  role_arn        = aws_iam_role.this[0].arn
}

# ----------------------------------------------------------------------------------------------------------------------
# IAM policies
# ----------------------------------------------------------------------------------------------------------------------

resource "aws_iam_policy" "custom_policies" {
  for_each = {
    for idx, policy in var.custom_policies_json : tostring(idx) => policy
  }

  name   = "${var.iam_role_name_postfix}-${each.key}"
  policy = each.value
  tags   = var.tags
}

resource "aws_iam_role_policy_attachment" "custom_policies" {
  for_each = aws_iam_policy.custom_policies

  role       = aws_iam_role.this[0].name
  policy_arn = each.value.arn
}

resource "aws_iam_role_policy_attachment" "managed" {
  for_each = toset(var.aws_managed_policy_arns)

  role       = aws_iam_role.this[0].name
  policy_arn = each.key
}