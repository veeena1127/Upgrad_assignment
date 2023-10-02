# EC2 Instance Variables

# Instance Type
variable "instance_type" {
  description = "Instance Type"
  type = string
  default = "t2.micro"  
}

# Instance Key Pair
variable "instance_keypair" {
  description = "EC2 Key pair"
  type = string
  default = "upgrad-project"
}

# AWS EC2 Private Instance Count
variable "private_instance_count" {
  description = "Private Instances Count"
  type = number
  default = 1  
}
