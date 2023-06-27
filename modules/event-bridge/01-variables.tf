## ---------------------------------------------------------------------------------------------------------------------
## Variable Definition - Event Bridge Module - Project Delphinum
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
  default     = "devl"

  validation {
    condition     = can(regex("^devl$|^test$|^prod$", var.environment_name))
    error_message = "Err: environment is not valid."
  }
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

variable "lambda_function_base_name" {
  description = "Name of the target Lambda function"
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
  event_rule_name = "${var.project_name}-${var.event_rule_name}-${var.environment_name}-${data.aws_region.current.name}"
}


locals {
  lambda_function_arn = "arn:aws:lambda:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:function:${var.project_name}-${var.lambda_function_base_name}-${var.environment_name}-${data.aws_region.current.name}"
}


