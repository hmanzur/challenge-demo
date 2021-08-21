locals {
  default_settings = [
    {
      namespace = "aws:autoscaling:launchconfiguration"
      name      = "InstanceType"
      value     = var.app_instance_type
    },
    {
      namespace = "aws:ec2:vpc"
      name      = "VPCId"
      value     = aws_vpc.main.id
    },
    {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "DB_USER"
      value     = aws_db_instance.database.username
    },
    {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "DB_PASS"
      value     = aws_db_instance.database.password
    },
    {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "DB_NAME"
      value     = aws_db_instance.database.name
    },
    {
      namespace = "aws:elasticbeanstalk:application:environment"
      name      = "DB_HOST"
      value     = aws_db_instance.database.endpoint
    }
  ]

  settings = {
    Production : concat(local.default_settings, [
      {
        namespace = "aws:autoscaling:launchconfiguration"
        name      = "IamInstanceProfile"
        value     = "aws-elasticbeanstalk-ec2-role"
      },
      {
        namespace = "aws:elasticbeanstalk:application:environment"
        name      = "PORT"
        value     = 80 // In case of use ssl change for 443
      }
    ]),

    Stage : concat(local.default_settings, [
      {
        namespace = "aws:elasticbeanstalk:application:environment"
        name      = "PORT"
        value     = 80
      }
    ])
  }
}
