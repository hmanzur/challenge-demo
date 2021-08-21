/**
 * Generate random secret password
 *
 * @see https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
 */
resource "random_string" "db_password" {
  length           = 16
  special          = true
  override_special = "/@£$"
}

/**
 * Generate RDS MySQL Instance
 *
 * @see https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
 */
resource "aws_db_instance" "database" {
  identifier           = local.rds_name
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "5.7"
  name                 = "db-${var.owner}---${var.env}"
  instance_class       = var.db_instance_type
  parameter_group_name = "default.mysql5.7"
  username             = var.owner
  password             = random_string.db_password.result
  publicly_accessible  = true
  skip_final_snapshot  = true

  tags = local.tags
}