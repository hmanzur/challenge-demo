/**
 * Provision Cloud Front distribution only on Production
 *
 * @see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/aws_cloudfront_origin_access_identity
 **/
resource "aws_cloudfront_origin_access_identity" "default" {
  count = local.enable_cloudfront ? 1 : 0

  comment = "${var.owner} - ${var.env}"
}


/**
 * Provision Cloud Front distribution only on Production
 *
 * @see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution
 **/
resource "aws_cloudfront_distribution" "default" {
  count = local.enable_cloudfront ? 1 : 0

  origin {
    domain_name = aws_s3_bucket.website.bucket_regional_domain_name
    origin_id   = aws_s3_bucket.website.id

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.default[count.index].cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  logging_config {
    include_cookies = false
    bucket          = aws_s3_bucket.website.bucket_domain_name
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = aws_s3_bucket.website.id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US"]
    }
  }

  tags = local.tags
}