## ---------------------------------------------------------------------------------------------------------------------
## Output - Lambda Module - Project Delphinum
## Modification History:
##   - 1.0.0    Jun 24,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

output "lambda_function_arn" {
  value = aws_lambda_function.lambda-function.arn
}

output "lambda_function_invoke_arn" {
  value = aws_lambda_function.lambda-function.invoke_arn
}

output "lambda_function_last_modified" {
  value = aws_lambda_function.lambda-function.last_modified
}

output "lambda_function_qualified_arn" {
  value = aws_lambda_function.lambda-function.qualified_arn
}



# qualified_invoke_arn 
# signing_job_arn 
# signing_profile_version_arn 
# snap_start.optimization_status - Optimization status of the snap start configuration. Valid values are On and Off.
# source_code_size 
# tags_all 
# version 
# vpc_config.vpc_id 
