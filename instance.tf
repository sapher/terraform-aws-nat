data "aws_ami" "this" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-*-hvm-*-arm64-gp2"]
  }
}

resource "aws_network_interface" "this" {
  count             = var.enabled ? 1 : 0
  subnet_id         = var.public_subnet_id
  source_dest_check = false
  security_groups   = [aws_security_group.this[0].id]
  tags              = merge({ Name : var.name }, var.tags)
}

resource "aws_instance" "nat" {
  count         = var.enabled ? 1 : 0
  ami           = data.aws_ami.this.id
  instance_type = var.instance_type

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.this[0].id
  }

  # Configure NAT instance
  user_data = <<EOF
  #!/bin/bash
  sudo sysctl -w net.ipv4.ip_forward=1
  sudo /sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
  sudo yum install iptables-services
  sudo service iptables save
  EOF

  tags = merge({ Name : var.name }, var.tags)
}
