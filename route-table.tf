# Route all egress internet traffic in private subnets to NAT instance ENI
resource "aws_route" "this" {
  count                  = var.enabled ? length(var.private_route_table_ids) : 0
  route_table_id         = var.private_route_table_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_network_interface.this[0].id
}
