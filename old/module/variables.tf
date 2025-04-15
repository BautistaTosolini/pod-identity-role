# ----------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# ----------------------------------------------------------------------------------------------------------------------
variable "iam_role_name_postfix" {
  description = "IAM Role for Service Account postfix name"
  type        = string
}

variable "cluster_name" {
  description = "The name of the cluster."
  type        = string
}

variable "namespace_service_accounts" {
  description = "Service Accounts to be associated with the IAM Role and his respective namespace. This is an array of JSON formatted strings."
  type = list(object({
    namespace            = string
    service_account = string
  }))
}

# ----------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# ----------------------------------------------------------------------------------------------------------------------
variable "custom_policies_json" {
  description = "Policies to add to the IAM Role. This is an array of JSON formatted strings."
  type        = list(string)
  default     = []
}

variable "aws_managed_policy_arns" {
  description = "ARNs list of AWS managed policies to attach to the role."
  type        = list(string)
  default     = []
}

variable "description" {
  description = "Description of the IAM Role."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to the IAM role."
  type        = map(any)
  default     = {}
}

