## ---------------------------------------------------------------------------------------------------------------------
#Lambda - Main - Project Delphinum
## Modification History:
##   - 1.0.0    Jun 24,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

## Lambda Function
resource "aws_lambda_function" "lambda-function" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename                       = "../modules/lambda/code/delphinum_code.zip"
  function_name                  = local.lambda_function_name
  description                    = var.lambda_function_description
  role                           = local.lambda_execution_iam_role_arn
  handler                        = "delphinum_code.lambda_handler"
  memory_size                    = var.memory_size
  timeout                        = var.timeout
  runtime                        = var.runtime
  source_code_hash               = data.archive_file.package_zip.output_base64sha256
  reserved_concurrent_executions = var.reserved_concurrent_executions

  environment {
    variables = {
      S3_BUCKET_NAME    = "${local.s3_bucket_name}"
      S3_DEFAULT_FOLDER = "${var.s3_default_folder}"
      SENDER            = "${var.sender_email}"
      RECIPIENT         = "${var.receipient_email}"
      CONFIGURATION_SET = "ConfigSet"
      CHARSET           = "UTF-8"
      SUBJECT           = "Good Morning  !"
    }
  }

  tags = local.tags
}
