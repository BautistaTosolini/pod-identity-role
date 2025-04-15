# **Terraform Module: Pod Identity Role**

## **Overview**

This Terraform module creates an IAM Role with the ability to attach both custom policies and existing AWS managed policies. Additionally, it creates a Pod Identity Association with a service account, allowing cluster pods to assume roles in AWS.

## **Features**

* ✅ **Creates an IAM Role.**
* ✅ **Supports attaching custom and AWS managed policies.**
* ✅ **Creates a Pod Identity Association with a Service Account in the cluster.**
* ✅ **Allows pods to assume roles and access AWS resources.**


## **Requirements**

* Terraform `>= 1.0.0, <=1.5.5`
* AWS provider `~> 5.5`
* AWS CLI configured with appropriate IAM permissions.
* IAM permissions for creating IAM Roles, attaching policies and modifying EKS cluster access.

---

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the EKS Cluster. | `string` | n/a | yes |
| <a name="input_iam_role_name_postfix"></a> [iam\_role\_name\_postfix](#input\_iam\_role\_name\_postfix) | IAM Role for Service Account postfix name. | `string` | n/a | yes |
| <a name="input_namespace_service_accounts"></a> [namespace\_service\_accounts](#input\_namespace\_service\_accounts) | Service Accounts to be associated with the IAM Role and their respective namespace. This is an array of JSON formatted strings. | `map(string)` | n/a | yes |
| <a name="input_custom_policy_json"></a> [custom\_policies\_json](#input\_custom\_policy\_json) | Policies to add to the IAM Role. This is an array of JSON formatted strings. | `list(string)` | `[]` | no |
| <a name="input_policy"></a> [aws\_managed\_policy\_arns](#input\_policy) | ARNs list of AWS managed policies to attach to the role. | `list(string)` | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the IAM Role. | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add the the IAM role. | `map(any)` | `{}` | no |
---

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_iam_policy_arn"></a> [iam\_policy\_arn](#output\_iam\_policy\_arn) | ARN of the IAM Policy. |
| <a name="output_iam_policy_name"></a> [iam\_policy\_name](#output\_iam\_policy\_name) | Name of the IAM Policy. |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | ARN of the IAM role. |
| <a name="output_iam_role_name"></a> [iam\_role\_name](#output\_iam\_role\_name) | Name of the IAM role. |
