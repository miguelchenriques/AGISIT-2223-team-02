# Terraform Openstack (VM Cloud) multi tier deployment

# Elements of the cloud such as virtual servers,
# networks, firewall rules are created as resources
# syntax is: resource RESOURCE_TYPE RESOURCE_NAME
# https://www.terraform.io/docs/configuration/resources.html
# https://www.terraform.io/docs/providers/openstack/

###########  KEYPAIR   #############
# https://www.terraform.io/docs/providers/openstack/r/compute_keypair_v2.html
# The following process creates a random name for the keypair, avoiding conflicts in  the project
resource "random_string" "random_name" {
 length  = 4
 special = false
 upper   = false
 lower   = true
}

resource "openstack_compute_keypair_v2" "keypair" {
 name       = random_string.random_name.result
 public_key = file(var.ssh_key_public)
}

###########  Web Servers   #############
# This method creates as many identical instances as the "count" index value
resource "openstack_compute_instance_v2" "web" {
  count           = 2
  name            = "web${count.index+1}"
  image_name      = "Ubuntu-Focal-Latest"
  flavor_name     = "t1.nano"
  key_pair        = openstack_compute_keypair_v2.keypair.name
  security_groups = ["default", openstack_compute_secgroup_v2.sec_ingr.name]

  network {
    name = var.unique_network_name
 }
}

###########  Load Balancer   #############
resource "openstack_compute_instance_v2" "balancer" {
  name            = "balancer"
  image_name      = "Ubuntu-Focal-Latest"
  flavor_name     = "t1.micro"
  key_pair        = openstack_compute_keypair_v2.keypair.name
  # security_groups = ["default"]
  security_groups = ["default", openstack_compute_secgroup_v2.sec_ingr.name]

  network {
    name = var.unique_network_name
  }
}


