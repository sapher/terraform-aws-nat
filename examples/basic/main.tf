module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-2a", "eu-west-2b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_dns_support   = true
  enable_dns_hostnames = true

  enable_nat_gateway = false
  single_nat_gateway = false
  enable_vpn_gateway = false
}

module "nat" {
  source = "../.."

  name                    = "nat"
  instance_type           = "t4g.nano"
  vpc_id                  = module.vpc.vpc_id
  public_subnet_id        = module.vpc.public_subnets[0]
  private_route_table_ids = module.vpc.private_route_table_ids
}
