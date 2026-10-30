output "vpc_id" {
  value = module.vpc.vpc_id
}

output "sg_id" {
  value = module.security-group.id
}

output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = module.s3-bucket.s3_bucket_id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.s3-bucket.s3_bucket_arn
}
