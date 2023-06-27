## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition - Project Delphinum
## Modification History:
##   - 1.0.0    Jun 24,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

data "aws_region" "current" {}
######################################## Project Name ##############################################
variable "project_name" {
  description = "The name of the project"
  type        = string
}
######################################## Environment Name ##########################################
variable "environment_name" {
  type        = string
  description = <<EOT
  (Optional) The environment in which to deploy our resources to.

  Options:
  - devl : Development
  - test: Test
  - prod: Production

  Default: devl
  EOT

  validation {
    condition     = can(regex("^devl$|^test$|^prod$", var.environment_name))
    error_message = "Err: environment is not valid."
  }
}
######################################## KMS Key ###################################################
variable "kms_key_alias" {
  description = "KMS Key Alias"
  type        = string
}

variable "kms_key_arn" {
  description = "KMS Key Arn"
  type        = string
}
################################## S3 Bucket #################################################
variable "s3_bucket_base_name" {
  description = "The base name of the S3 bucket"
  type        = string
}

variable "s3_default_folder" {
  description = "The default folder to be created"
  type        = string
}
######################################## IAM Role / Policy #########################################
variable "lambda_iam_role_name" {
  description = "The name of the Lambda IAM Role"
  type        = string
}

variable "lambda_iam_policy_name" {
  description = "The name of the Lambda IAM Policy"
  type        = string
}
######################################## Lambda Function  ##########################################
variable "lambda_function_base_name" {
  description = "The base name of the lambda function"
  type        = string
}

variable "lambda_function_description" {
  description = "The description of the lambda function"
  type        = string
}

variable "memory_size" {
  description = "The allocated memory size of the lambda function in MB"
  type        = number
  default     = 128
}

variable "runtime" {
  description = "The runtime the lambda function"
  type        = string
  default     = "python3.9"
}

variable "timeout" {
  description = "The timeout period of the lambda function in seconds"
  type        = number
}

variable "reserved_concurrent_executions" {
  description = "The reserved concurrency for the lambda function."
  type        = number
}
######################################## CloudWatch Event Rule #####################################
variable "event_rule_name" {
  description = "Name of CloudWatch Event Rule"
  type        = string
}

variable "event_rule_description" {
  description = "Description of CloudWatch Event Rule"
  type        = string
}

variable "schedule_expression" {
  description = "CloudWatch Event Rule Cron Expression"
  type        = string
}
######################################## SES #######################################################
variable "receipient_email" {
  description = "The email id of the receipient"
  type        = string
}

variable "sender_email" {
  description = "The email id of the sender"
  type        = string
}
####################################### SNS Topic #################################################
# variable "sns_topic_base_name" {
#   description = "The base name of the SNS Topic"
#   type        = string
# }

# variable "sns_topic_display_name" {
#   description = "The display name of the SNS Topic"
#   type        = string
# }
####################################### SNS Topic Subscription ####################################
# variable "sns_subscription_email" {
#   description = "The SNS subscription email"
#   type        = list(string)
# }
