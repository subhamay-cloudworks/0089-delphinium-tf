## ---------------------------------------------------------------------------------------------------------------------
## S3 - Main - Project Delphinum
## Modification History:
##   - 1.0.0    Jun 24,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

########################################  S3 Bucket ################################################
resource "aws_s3_bucket" "s3_bucket" {
  bucket        = local.bucket_name
  force_destroy = true

  tags = local.tags
}
######################################## S3 Default Folder #########################################
resource "aws_s3_object" "s3_bucket_default_folder" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "private"
  key    = "${var.s3_default_folder}/"
  source = "/dev/null"
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_owner_control" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_owner_control]

  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "private"
}
######################################## SSE Encryption ############################################
resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_sse" {
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.kms_key_alias
      sse_algorithm     = "aws:kms"
    }
  }
}
######################################## Upload Images to S3 Bucket ################################
resource "aws_s3_object" "s3_object" {
  for_each = fileset("${path.module}/images/", "**")
  bucket   = aws_s3_bucket.s3_bucket.id
  key      = "good-morning/${each.value}"
  source   = "${path.module}/images/${each.value}"
  etag     = filemd5("${path.module}/images/${each.value}")
}