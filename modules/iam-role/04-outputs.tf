## ---------------------------------------------------------------------------------------------------------------------
## Output - IAM Role Module - Project Delphinum
## Modification History:
##   - 1.0.0    Jun 24,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

output "lambda_iam_role_arn" {
  value = aws_iam_role.lambda-iam-role.arn
}
