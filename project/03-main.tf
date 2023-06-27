## ---------------------------------------------------------------------------------------------------------------------
## Project Delphinum - Main 
## Modification History:
##   - 1.0.0    Jun 24,2023   -- Initial Version
## This project will deploy the following resources:

## A S3 Bucket with default folder to images
## A Lambda Function
## An EventBridge Rule
## A SES 
## Related IAM Role and Policy
## ---------------------------------------------------------------------------------------------------------------------

## S3 Bucket with default folder
module "delphinum_s3_bucket" {
  source              = "../modules/s3"
  project_name        = var.project_name
  environment_name    = var.environment_name
  s3_bucket_base_name = var.s3_bucket_base_name
  s3_default_folder   = var.s3_default_folder
  kms_key_alias       = var.kms_key_alias
}

## Lambda Execution Role
module "delphinum_lambda_execution_role" {
  source                    = "../modules/iam-role"
  project_name              = var.project_name
  environment_name          = var.environment_name
  lambda_iam_role_name      = var.lambda_iam_role_name
  lambda_iam_policy_name    = var.lambda_iam_policy_name
  lambda_function_base_name = var.lambda_function_base_name
  kms_key_arn               = var.kms_key_arn
  s3_bucket_base_name       = var.s3_bucket_base_name
  s3_default_folder         = var.s3_default_folder
  receipient_email          = var.receipient_email
  sender_email              = var.sender_email
}

## Lambda Function
module "delphinum_lambda_function" {
  source                         = "../modules/lambda"
  project_name                   = var.project_name
  environment_name               = var.environment_name
  lambda_function_base_name      = var.lambda_function_base_name
  lambda_function_description    = var.lambda_function_description
  lambda_iam_role_name           = var.lambda_iam_role_name
  memory_size                    = var.memory_size
  timeout                        = var.timeout
  runtime                        = var.runtime
  reserved_concurrent_executions = var.reserved_concurrent_executions
  s3_bucket_base_name            = var.s3_bucket_base_name
  s3_default_folder              = var.s3_default_folder
  receipient_email               = var.receipient_email
  sender_email                   = var.sender_email
}


## EventBridge Rule
module "delphinum_event_rule" {
  source                    = "../modules/event-bridge"
  project_name              = var.project_name
  environment_name          = var.environment_name
  event_rule_name           = var.event_rule_name
  event_rule_description    = var.event_rule_description
  schedule_expression       = var.schedule_expression
  lambda_function_base_name = var.lambda_function_base_name

}