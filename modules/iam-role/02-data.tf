## ---------------------------------------------------------------------------------------------------------------------
## Data Definition - IAM Role Module - Project Delphinum
## Modification History:
##   - 1.0.0    Jun 24,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

# AWS Region and Caller Identity
data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

# Lambda IAM Policy Document
data "aws_iam_policy_document" "lambda-iam-policy-document" {
  statement {
    sid = "AllowCloudWatchLogStream"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${local.lambda_function_name}:*",
    ]
  }

  statement {
    sid = "AllowS3ReadAndGetObject"
    actions = [
      "s3:Get*",
      "s3:List*",
      "s3-object-lambda:Get*",
      "s3-object-lambda:List*"
    ]
    resources = ["arn:aws:s3:::${local.bucket_name}", "arn:aws:s3:::${local.bucket_name}/*"]
  }

  statement {
    sid = "AllowKMSDecryption"

    actions = [
      "kms:Decrypt",
      "kms:Encrypt",
      "kms:GenerateDataKey",
      "kms:GenerateDataKeyPair"
    ]

    resources = [
      "${var.kms_key_arn}"
    ]
  }

  statement {
    sid = "AllowSESSendMail"
    actions = [
      "ses:GetIdentityVerificationAttributes",
      "ses:SendEmail",
      "ses:SendRawEmail",
      "ses:VerifyEmailIdentity"
    ]
    resources = ["arn:aws:ses:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:identity/${var.receipient_email}",
    "arn:aws:ses:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:identity/${var.sender_email}"]
  }
}


