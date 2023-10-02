# Get self IP from API
# Bastion Host Security Group
module "public_bastion_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name = "public-bastion-sg"
  description = "Rules to allow Ingress from "
  vpc_id = module.vpc.vpc_id
  # Ingress Rules with Self IP
  ingress_rules = ["ssh-tcp"]
  ingress_cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags
}
