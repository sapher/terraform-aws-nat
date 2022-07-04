resource "aws_security_group" "this" {
  vpc_id = var.vpc_id
  name   = "nat"
  tags   = merge({ Name : var.name }, var.tags)
}

# Accept all ingress connections from any IP in VPC CIDR
resource "aws_security_group_rule" "ingress" {
  from_port         = 0
  protocol          = "all"
  security_group_id = aws_security_group.this.id
  to_port           = 0
  cidr_blocks       = [data.aws_vpc.this.cidr_block]
  type              = "ingress"
}

resource "aws_security_group_rule" "egress" {
  from_port         = 0
  protocol          = "all"
  security_group_id = aws_security_group.this.id
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "egress"
}
