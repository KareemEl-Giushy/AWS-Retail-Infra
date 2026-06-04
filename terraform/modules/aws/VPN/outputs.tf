# ------------------------------------------------------------
# Outputs for AWS ↔ Azure Site-to-Site VPN
# ------------------------------------------------------------

# AWS tunnel endpoint IP — feed into Azure local_networks
output "aws_vpn_tunnel1_ip" {
  value       = aws_vpn_connection.main.tunnel1_address
  description = "AWS tunnel endpoint — use this in Azure local_networks.local_gateway_address"
}

# AWS tunnel pre-shared key — must match Azure shared_key
output "aws_vpn_tunnel1_psk" {
  value     = aws_vpn_connection.main.tunnel1_preshared_key
  sensitive = true
}

# Azure VPN Gateway public IP — feed into AWS customer_gateway
output "azure_vpn_gateway_ip" {
  value       = module.vpn-gateway.vpn_gateway_public_ip
  description = "Azure VPN Gateway public IP — use this in AWS customer_gateway.ip_address"
}

# Azure VPN Gateway name
output "azure_vpn_gateway_name" {
  value       = module.vpn-gateway.vpn_gateway_name
  description = "Name of the Azure VPN Gateway resource"
}

# Azure VPN Gateway resource group
output "azure_vpn_gateway_rg" {
  value       = module.vpn-gateway.resource_group_name
  description = "Resource group containing the Azure VPN Gateway"
}
