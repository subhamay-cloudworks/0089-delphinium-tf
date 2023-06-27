## ---------------------------------------------------------------------------------------------------------------------
## Output - Project Delphinum
## Modification History:
##   - 1.0.0    Jun 24,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

######################################## S3 Bucket #################################################
output "delphinum_s3_bucket_arn" {
  value = module.delphinum_s3_bucket.s3_bucket_arn
}

output "delphinum_s3_bucket_id" {
  value = module.delphinum_s3_bucket.s3_bucket_id
}

output "delphinum_s3_bucket_region" {
  value = module.delphinum_s3_bucket.s3_bucket_region
}

output "delphinum_s3_bucket_domain_name" {
  value = module.delphinum_s3_bucket.s3_bucket_domain_name
}

output "delphinum_s3_bucket_regional_domain_name" {
  value = module.delphinum_s3_bucket.s3_bucket_regional_domain_name
}

output "delphinum_s3_bucket_tags_all" {
  value = module.delphinum_s3_bucket.s3_bucket_tags_all
}
######################################## IAM Role #################################################
output "delphinum_lambda_iam_role_arn" {
  value = module.delphinum_lambda_execution_role.lambda_iam_role_arn
}
######################################## Lambda #################################################
output "delphinum_lambda_function_invoke_arn" {
  value = module.delphinum_lambda_function.lambda_function_arn
}

output "delphinum_lambda_function_last_modified" {
  value = module.delphinum_lambda_function.lambda_function_last_modified
}

output "delphinum_lambda_function_qualified_arn" {
  value = module.delphinum_lambda_function.lambda_function_qualified_arn
}
######################################## EventBridge Rule ##########################################
output "delphinum_event_rule_id" {
  value = module.delphinum_event_rule.cloudwatch_event_rule_id
}

output "delphinum_event_rule_arn" {
  value = module.delphinum_event_rule.cloudwatch_event_rule_arn
}

output "delphinum_event_rule_tags_all" {
  value = module.delphinum_event_rule.cloudwatch_event_rule_tags_all
}
