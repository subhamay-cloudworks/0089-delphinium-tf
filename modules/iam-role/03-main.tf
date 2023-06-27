## ---------------------------------------------------------------------------------------------------------------------
## IAM Role - Main - Project Delphinum
## Modification History:
##   - 1.0.0    Jun 24,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

######################################## Lambda IAM Role ###########################################
resource "aws_iam_role" "lambda-iam-role" {
  name        = local.lambda_iam_role_name
  description = "Delphinum Lambda execution role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = "LambdaTrustPolicy"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  tags = local.tags
}
######################################## Lambda IAM Policy #########################################
resource "aws_iam_policy" "lambda-iam-policy" {
  name        = local.lambda_iam_policy_name
  path        = "/"
  description = "Delphinum Lambda execution policy"


  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = data.aws_iam_policy_document.lambda-iam-policy-document.json
}
######################################## Lambda IAM Role / Policy attachment #######################
resource "aws_iam_role_policy_attachment" "lambda-iam-role-policy-attachment" {
  depends_on = [aws_iam_role.lambda-iam-role, aws_iam_policy.lambda-iam-policy]

  role       = aws_iam_role.lambda-iam-role.name
  policy_arn = aws_iam_policy.lambda-iam-policy.arn
}
