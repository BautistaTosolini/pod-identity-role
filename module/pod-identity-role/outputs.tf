# output "iam_role_name" {
#   description = "Name of the IAM role."
#   value       = length(aws_iam_role.this) > 0 ? aws_iam_role.this[0].name : null
# }

# output "iam_role_arn" {
#   description = "ARN of the IAM role."
#   value       = length(aws_iam_role.this) > 0 ? aws_iam_role.this[0].arn : null
# }

# output "iam_policy_name" {
#   description = "Name of the IAM Policy."
#   value       = length(aws_iam_policy.custom_policies) > 0 ? aws_iam_policy.custom_policies[0].name : null
# }

# output "iam_policy_arn" {
#   description = "ARN of the IAM Policy."
#   value       = length(aws_iam_policy.custom_policies) > 0 ? aws_iam_policy.custom_policies[0].arn : null
# }

# output "managed_policies" {
#   value = local.managed_policies
# }

# output "formatted_managed_policies" {
#   value = local.formatted_managed_policies
# }

# # output "custom_policies" {
# #   value = local.custom_policies
# # }

# output "formatted_custom_policies" {
#   value = local.formatted_custom_policies
# }