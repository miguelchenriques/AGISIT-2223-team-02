# Terraform GCP
# To output variables, follow pattern:
# value = TYPE.NAME.ATTR

output "balancer" {
  value = formatlist("%s = %s", google_compute_instance.balancer[*].name, google_compute_instance.balancer[*].network_interface.0.access_config.0.nat_ip)
}

output "balancer_ssh" {
 value = google_compute_instance.balancer[*].self_link
}

# example for a set of identical instances created with "count"
output "web_IPs"  {
  value = formatlist("%s = %s", google_compute_instance.operations[*].name, google_compute_instance.operations[*].network_interface.0.access_config.0.nat_ip)
}

output "frontend"  {
  value = formatlist("%s = %s", google_compute_instance.frontend[*].name, google_compute_instance.frontend[*].network_interface.0.access_config.0.nat_ip)
}

output "monitor" {
  value = join(" ", google_compute_instance.monitor.*.network_interface.0.access_config.0.nat_ip)
}