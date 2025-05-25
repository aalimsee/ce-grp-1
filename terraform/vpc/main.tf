provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = "ce-grp-1-vpc"
  cidr = "14.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["14.0.1.0/24", "14.0.2.0/24", "14.0.3.0/24"]
  public_subnets  = ["14.0.101.0/24", "14.0.102.0/24", "14.0.103.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Subnet tags
  public_subnet_tags = {
    Name = "ce-grp-1-public"
  }

  private_subnet_tags = {
    Name = "ce-grp-1-private"
  }

  # VPC tag
  tags = {
    Name        = "ce-grp-1"
    Environment = "dev"
  }

  # Route table tags
  default_route_table_tags = {
    Name = "ce-grp-1-default-rt"
  }
  public_route_table_tags = {
    Name = "ce-grp-1-public-rt"
  }
  private_route_table_tags = {
    Name = "ce-grp-1-private-rt"
  }

  default_network_acl_tags = {
    Name = "ce-grp-1-default-acl"
  }

  default_security_group_tags = {
    Name = "ce-grp-1-default-sg"
  }

  # NAT Gateway tag
  nat_gateway_tags = {
    Name = "ce-grp-1-nat-gw"
  }
  # Internet Gateway tag
  igw_tags = {
    Name = "ce-grp-1-igw"
  }
}
