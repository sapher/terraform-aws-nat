resource "aws_security_group" "this" {
  count  = var.enabled ? 1 : 0
  vpc_id = var.vpc_id
  name   = "nat"
  tags   = merge({ Name : var.name }, var.tags)
}

# Accept all ingress connections from any IP in VPC CIDR
resource "aws_security_group_rule" "ingress" {
  count             = var.enabled ? 1 : 0
  from_port         = 0
  protocol          = "all"
  security_group_id = aws_security_group.this[0].id
  to_port           = 0
  cidr_blocks       = [data.aws_vpc.this.cidr_block]
  type              = "ingress"
}

resource "aws_security_group_rule" "egress" {
  count             = var.enabled ? 1 : 0
  from_port         = 0
  protocol          = "all"
  security_group_id = aws_security_group.this[0].id
  to_port           = 0
  cidr_blocks       = ["0.0.0.0/0"]
  type              = "egress"
}
