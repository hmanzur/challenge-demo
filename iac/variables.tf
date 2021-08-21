variable "env" {
  type        = string
  default     = "Production"
  description = "Infraestructure environment"
}

variable "owner" {
  type        = string
  default     = "habidmanzur"
  description = "Me"
}

variable "app_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "App Ec2 instance type"
}

variable "db_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "App RDS instance type"
}

variable "ingress_rules" {
  default = []
}