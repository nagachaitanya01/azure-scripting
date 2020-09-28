output "public-ips" {
  value       = "${azurerm_public_ip.pips.*.ip_address}"      ====================>for displaying public ips in TF plan 
}
