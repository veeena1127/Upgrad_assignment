# Security Group for Private Instances
module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name = "private-sg"
  description = "Allow all ingress traffic from within VPC and allow all egress to the internet"
  vpc_id = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules = ["all-all"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags
}
