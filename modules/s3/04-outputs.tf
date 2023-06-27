## ---------------------------------------------------------------------------------------------------------------------
## Output - S3 Module - Project Delphinum
## Modification History:
##   - 1.0.0    Jun 24,2023   -- Initial Version
## ---------------------------------------------------------------------------------------------------------------------

######################################## AWS REGION ################################################
output "current_region" {
  value = data.aws_region.current.name
}

output "current_region_description" {
  value = data.aws_region.current.description
}
######################################## S3 Bucket #################################################
output "s3_bucket_arn" {
  value = aws_s3_bucket.s3_bucket.arn
}

output "s3_bucket_id" {
  value = aws_s3_bucket.s3_bucket.id
}

output "s3_bucket_region" {
  value = aws_s3_bucket.s3_bucket.region
}

output "s3_bucket_domain_name" {
  value = aws_s3_bucket.s3_bucket.bucket_domain_name
}

output "s3_bucket_regional_domain_name" {
  value = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
}

output "s3_bucket_tags_all" {
  value = aws_s3_bucket.s3_bucket.tags_all
}
