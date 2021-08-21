locals {
  enable_cloudfront = var.env == "Production"

  s3_bucket_name = lower("website-${var.owner}---${var.env}")
  vpc_name       = lower("vpc-${var.owner}---${var.env}")
  sg_name        = lower("${var.owner}---${var.env}")   # Segurity group name always starts with sg-
  rds_name       = lower("rds-${var.owner}-${var.env}") # Due "identifier" cannot contain two consecutive hyphens

  eb_env_name = title("${var.owner} ${var.env}")
  eb_app_name = "${var.env}---${var.owner}"

  tags = {
    Terraform   = true
    Owner       = var.owner
    Link        = "https://github.com/hmanzur"
    Environment = var.env,
    Workspace   = terraform.workspace
  }
}