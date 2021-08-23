/*
 * Provides a policy to destroy beanstalk bucket on destruction
 * 
 * @see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
 */
resource "aws_iam_role" "beanstalk_service" {
  name               = "${var.owner}-eb-service-role"
  assume_role_policy = file("./files/eb-servie-role.json")
  tags               = local.tags
}

/**
 * Provision Elastic Beanstalk Application
 *
 * @see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elastic_beanstalk_application
 */
resource "aws_elastic_beanstalk_application" "app" {
  name        = local.eb_app_name
  description = "${var.env} EB Application by ${var.owner}"
  tags        = local.tags

  appversion_lifecycle {
    service_role          = aws_iam_role.beanstalk_service.arn
    max_count             = 30
    delete_source_from_s3 = true
  }

  depends_on = [
    aws_vpn_gateway.vpn_gw
  ]
}