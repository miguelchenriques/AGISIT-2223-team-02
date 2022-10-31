# Terraform Openstack (VM Cloud) multi tier deployment

#  creating security group to allow access to  servers through HTTP and HTTPS

resource "openstack_compute_secgroup_v2" "sec_ingr" {
  name        = "sec_ingr"
  description = "a security group"

  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 443
    to_port     = 443
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}
