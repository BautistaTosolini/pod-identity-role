output "iam_role_name" {
  description = "Name of the IAM role"
  value       = length(aws_iam_role.this) > 0 ? aws_iam_role.this[0].name : null
}

output "iam_role_arn" {
  description = "ARN of the IAM role"
  value       = length(aws_iam_role.this) > 0 ? aws_iam_role.this[0].arn : null
}

output "iam_policy_name" {
  description = "Name of the IAM Policy"
  value       = length(aws_iam_policy.custom_policies) > 0 ? aws_iam_policy.custom_policies[0].name : null
}

output "iam_policy_arn" {
  description = "ARN of the IAM Policy"
  value       = length(aws_iam_policy.custom_policies) > 0 ? aws_iam_policy.custom_policies[0].arn : null
}