# ----------------------------------------------------------------------------------------------------------------------
# REQUIRED PARAMETERS
# ----------------------------------------------------------------------------------------------------------------------
variable "cluster_name" {
  description = "The name of the cluster."
  type        = string
}

variable "path_to_roles_json" {
  description = "The path to the JSON containing the roles and policies."
  type        = string
}

# ----------------------------------------------------------------------------------------------------------------------
# OPTIONAL PARAMETERS
# ----------------------------------------------------------------------------------------------------------------------
variable "aws_region" {
  description = "The AWS Region where this VPC will exist."
  type        = string
  default     = "us-east-1"
}

variable "tags" {
  description = "A map of tags to add to the IAM role."
  type        = map(any)
  default     = {}
}