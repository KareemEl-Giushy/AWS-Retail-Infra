variable "vpc_endpoint" {
  type = map(string)
}
resource "aws_vpc_endpoint" "aws_vpc_endpoints" {
  for_each            = var.vpc_endpoint
  vpc_id              = aws_vpc.main.id
  subnet_ids          = [aws_subnet.private_subnet.id]
  service_name        = each.value
  vpc_endpoint_type   = "Interface"
  private_dns_enabled = true
  ip_address_type     = "ipv4"
  tags = {
    Name = each.key
  }
}

