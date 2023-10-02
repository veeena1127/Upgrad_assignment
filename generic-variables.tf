variable "aws_region" {
  description = "AWS resource region"
  type = string
  default = "us-east-1"  
}

# Environment Variable
variable "environment" {
  description = "Environment Variable"
  type = string
  default = "dev-terraform"
}


# Owner Variable
variable "owner" {
  description = "Owner Variable"
  type = string
  default = "Veena Chaudhari"
}
