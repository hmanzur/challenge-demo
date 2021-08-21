/**
 * Provision Elastic Beanstalk Environment
 *
 * @see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/aws_elastic_beanstalk_environment
 */
resource "aws_elastic_beanstalk_environment" "env" {
  name                = local.eb_env_name
  application         = aws_elastic_beanstalk_application.app.name
  solution_stack_name = "64bit Amazon Linux 2 v5.4.4 running Node.js 14"

  cname_prefix = lower("${var.owner}-${var.env}")

  dynamic "setting" {
    for_each = local.settings[var.env]

    content {
      namespace = setting.value["namespace"]
      name      = setting.value["name"]
      value     = setting.value["value"]
    }
  }

  tags = local.tags
}