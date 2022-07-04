## AWS nat instance module

Terraform module which create a single NAT instance in the public subnet of a VPC that will route all private subnets egress to the NAT and then to the internet.

Using a NAT instance instead of NAT gateway is a good way to save money on development environment.

## Usage

```hcl
# We use VPC module for the example
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
```

## Requirements

No requirements.

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                               | Type        |
| ---------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_instance.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)                           | resource    |
| [aws_network_interface.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_interface)        | resource    |
| [aws_route.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route)                                | resource    |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)              | resource    |
| [aws_security_group_rule.egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule)  | resource    |
| [aws_security_group_rule.ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource    |
| [aws_ami.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami)                                 | data source |
| [aws_vpc.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc)                                 | data source |

## Inputs

| Name                                                                                                   | Description                                     | Type           | Default     | Required |
| ------------------------------------------------------------------------------------------------------ | ----------------------------------------------- | -------------- | ----------- | :------: |
| <a name="input_enabled"></a> [enabled](#input_enabled)                                                 | Enable module                                   | `bool`         | `true`      |    no    |
| <a name="input_instance_type"></a> [instance_type](#input_instance_type)                               | Instance type                                   | `string`       | `"t3.nano"` |    no    |
| <a name="input_name"></a> [name](#input_name)                                                          | Nat instance name                               | `string`       | n/a         |   yes    |
| <a name="input_private_route_table_ids"></a> [private_route_table_ids](#input_private_route_table_ids) | IDs for private route table                     | `list(string)` | n/a         |   yes    |
| <a name="input_public_subnet_id"></a> [public_subnet_id](#input_public_subnet_id)                      | Public subnet ID where nat instance is deployed | `string`       | n/a         |   yes    |
| <a name="input_tags"></a> [tags](#input_tags)                                                          | Optional tags for all resources                 | `map(string)`  | `{}`        |    no    |
| <a name="input_vpc_id"></a> [vpc_id](#input_vpc_id)                                                    | VPC Id                                          | `string`       | n/a         |   yes    |

## Outputs

| Name                                                                                                  | Description            |
| ----------------------------------------------------------------------------------------------------- | ---------------------- |
| <a name="output_nat_instance_public_ip"></a> [nat_instance_public_ip](#output_nat_instance_public_ip) | Nat instance public IP |
