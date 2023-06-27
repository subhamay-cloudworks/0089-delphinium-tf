## ---------------------------------------------------------------------------------------------------------------------
## Output - EventBridge Module - Project Delphinum
## Modification History:
##   - 1.0.0    Jun 26,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

######################################## AWS REGION ################################################
output "current_region" {
  value = data.aws_region.current.name
}

output "current_region_description" {
  value = data.aws_region.current.description
}
######################################## EventBridge Rule ##########################################
output "cloudwatch_event_rule_id" {
  value = aws_cloudwatch_event_rule.cloudwatch_event_rule.id
}

output "cloudwatch_event_rule_arn" {
  value = aws_cloudwatch_event_rule.cloudwatch_event_rule.arn
}

output "cloudwatch_event_rule_tags_all" {
  value = aws_cloudwatch_event_rule.cloudwatch_event_rule.tags_all
}
