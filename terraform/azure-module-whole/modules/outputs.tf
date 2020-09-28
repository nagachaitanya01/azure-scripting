output "public-ips" {
  value       = "${azurerm_public_ip.pips.*.ip_address}"
}
