output "tags" {
  value = local.tags
}

output "domain" {
  value = aws_cloudfront_distribution.default[*].domain_name
}