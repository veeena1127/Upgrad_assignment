# Security Group for App Instance
module "web_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  name = "web-sg"
  description = "Allow incoming traffic on port 80 from Self IP and allow all egress"
  vpc_id = module.vpc.vpc_id
  # Ingress Rules & CIDR Blocks
  ingress_rules = ["ssh-tcp", "http-80-tcp"]
  ingress_cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]
  tags = local.common_tags
}
