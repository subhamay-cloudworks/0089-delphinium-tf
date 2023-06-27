## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition - IAM Role Module - Project Delphinum
## Modification History:
##   - 1.0.0    Jun 24,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

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
variable "kms_key_arn" {
  description = "KMS Key Arn"
  type        = string
}
######################################## S3 Bucket #################################################
variable "s3_bucket_base_name" {
  description = "The base name of the S3 Bucket"
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
######################################## SES #######################################################
variable "receipient_email" {
  description = "The email id of the receipient"
  type        = string
}

variable "sender_email" {
  description = "The email id of the sender"
  type        = string
}
######################################## Local Variables ###########################################
locals {
  tags = tomap({
    Environment = var.environment_name
    ProjectName = var.project_name
  })
}

locals {
  lambda_function_name = "${var.project_name}-${var.lambda_function_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}

locals {
  bucket_name = "${var.project_name}-${var.s3_bucket_base_name}-${data.aws_caller_identity.current.account_id}-${var.environment_name}-${data.aws_region.current.name}"
}

locals {
  lambda_iam_role_name = "${var.project_name}-${var.lambda_iam_role_name}"
}

locals {
  lambda_iam_policy_name = "${var.project_name}-${var.lambda_iam_policy_name}"
}

