/** 
 * Provision Website Bucket
 *
 * @see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket
 */
resource "aws_s3_bucket" "website" {
  bucket = local.s3_bucket_name

  acl = "public-read"

  policy = templatefile("${path.module}/files/website-policy.json.tpl", {
    bucket = local.s3_bucket_name
  })

  force_destroy = true

  lifecycle {
    prevent_destroy = false
  }

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  tags = local.tags
}