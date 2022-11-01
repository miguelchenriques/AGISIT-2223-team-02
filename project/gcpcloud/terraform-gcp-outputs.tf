# Terraform GCP
# To output variables, follow pattern:
# value = TYPE.NAME.ATTR

output "balancer" {
  value = formatlist("%s = %s", google_compute_instance.balancer[*].name, google_compute_instance.balancer[*].network_interface.0.access_config.0.nat_ip)
}

output "balancer_ssh" {
 value = google_compute_instance.balancer[*].self_link
}

output "adder"  {
  value = formatlist("%s = %s", google_compute_instance.adder[*].name, google_compute_instance.adder[*].network_interface.0.access_config.0.nat_ip)
}

output "multiplier"  {
  value = formatlist("%s = %s", google_compute_instance.multiplier[*].name, google_compute_instance.multiplier[*].network_interface.0.access_config.0.nat_ip)
}

output "frontend"  {
  value = formatlist("%s = %s", google_compute_instance.frontend[*].name, google_compute_instance.frontend[*].network_interface.0.access_config.0.nat_ip)
}

output "monitor" {
  value = join(" ", google_compute_instance.monitor.*.network_interface.0.access_config.0.nat_ip)
}

output "databases" {
  value = formatlist("%s = %s", google_compute_instance.database[*].name, google_compute_instance.database[*].network_interface.0.access_config.0.nat_ip)
}