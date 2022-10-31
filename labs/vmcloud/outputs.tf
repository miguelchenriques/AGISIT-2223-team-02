# Terraform Openstack (VMCloud) multi tier deployment
# To output variables, follow pattern:
# value = TYPE.NAME.ATTR

output "sec_rules" {
  description = "Outputs the sec_ingr rule"
  value = openstack_compute_secgroup_v2.sec_ingr.rule
 }

 output "private_key"  {
   value = file(var.ssh_key_private)
 }

 output "public_key"  {
   value = file(var.ssh_key_public)
 }

output "keypair" {
  value = openstack_compute_keypair_v2.keypair.name
}

 # example for a set of identical instances created with "count"
 output "web_IPs"  {
   value = formatlist("%s = %s", openstack_compute_instance_v2.web[*].name, openstack_compute_instance_v2.web[*].access_ip_v4)
   description = "initialized with success"
 }

output "balancer_IP"  {
  value = openstack_compute_instance_v2.balancer.access_ip_v4
  description = "initialized with success"
}
