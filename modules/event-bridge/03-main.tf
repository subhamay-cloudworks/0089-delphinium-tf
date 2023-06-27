## ---------------------------------------------------------------------------------------------------------------------
## EventBridge Rule - Main - Project Delphinum
## Modification History:
##   - 1.0.0    Jun 26,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

########################################  EventBridge Rule #########################################
resource "aws_cloudwatch_event_rule" "cloudwatch_event_rule" {
  name                = local.event_rule_name
  description         = var.event_rule_description
  schedule_expression = var.schedule_expression
  is_enabled          = true
  tags                = local.tags
}

resource "aws_cloudwatch_event_target" "cloudwatch_event_target" {
  rule      = aws_cloudwatch_event_rule.cloudwatch_event_rule.name
  target_id = "${var.project_name}_lambda_function"
  arn       = local.lambda_function_arn
}

resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "allow-execution-from-cloudwatch"
  action        = "lambda:InvokeFunction"
  function_name = local.lambda_function_arn
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cloudwatch_event_rule.arn
}