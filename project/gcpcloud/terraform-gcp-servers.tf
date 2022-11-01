
# Elemets of the cloud such as virtual servers,
# networks, firewall rules are created as resources
# syntax is: resource RESOURCE_TYPE RESOURCE_NAME
# https://www.terraform.io/docs/configuration/resources.html

###########  Frontend Servers   #############
# This method creates as many identical instances as the "count" index value
resource "google_compute_instance" "frontend" {
    # count = 2
    count = 1
    name = "frontend${count.index+1}"
    machine_type = var.GCP_MACHINE_TYPE
    zone = var.GCP_ZONE

    boot_disk {
        initialize_params {
          # image list can be found at:
          # https://cloud.google.com/compute/docs/images
          image = "ubuntu-2004-focal-v20221018"
        }
    }

    network_interface {
      network = "default"
      access_config {
      }
    }

    metadata = {
      ssh-keys = "ubuntu:${file("/home/vagrant/.ssh/id_rsa.pub")}"
    }
  tags = ["frontend"]
}


###########  Load Balancer   #############
resource "google_compute_instance" "balancer" {
    count = 2
    # count = 3
    name = "balancer${count.index+1}"
    machine_type = var.GCP_MACHINE_TYPE
    zone = var.GCP_ZONE

    boot_disk {
        initialize_params {
          # image list can be found at:
          # https://cloud.google.com/compute/docs/images
          image = "ubuntu-2004-focal-v20221018"
        }
    }

    network_interface {
      network = "default"
      access_config {
      }
    }

    metadata = {
      ssh-keys = "ubuntu:${file("/home/vagrant/.ssh/id_rsa.pub")}"
    }

  tags = ["balancer"]
}

###########  Operations Servers   #############
# This method creates as many identical instances as the "count" index value
resource "google_compute_instance" "operations" {
    count = 4
    name = "operations${count.index+1}"
    machine_type = var.GCP_MACHINE_TYPE
    zone = var.OPERATIONS_ZONE

    boot_disk {
        initialize_params {
          # image list can be found at:
          # https://cloud.google.com/compute/docs/images
          image = "ubuntu-2004-focal-v20221018"
        }
    }

    network_interface {
      network = "default"
      access_config {
      }
    }

    metadata = {
      ssh-keys = "ubuntu:${file("/home/vagrant/.ssh/id_rsa.pub")}"
    }
  tags = ["operations"]
}

resource "google_compute_instance" "monitor" {
    name = "monitor"
    machine_type = var.GCP_MACHINE_TYPE
    zone = var.OPERATIONS_ZONE

    boot_disk {
        initialize_params {
          # image list can be found at:
          # https://cloud.google.com/compute/docs/images
          image = "ubuntu-2004-focal-v20221018"
        }
    }

    network_interface {
      network = "default"
      access_config {
      }
    }

    metadata = {
      ssh-keys = "ubuntu:${file("/home/vagrant/.ssh/id_rsa.pub")}"
    }
  tags = ["monitor"]
}