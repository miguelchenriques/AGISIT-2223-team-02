
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
    count = 3
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
resource "google_compute_instance" "adder" {
    count = 2
    name = "adder${count.index+1}"
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

resource "google_compute_instance" "multiplier" {
    count = 2
    name = "multiplier${count.index+1}"
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

###########  Databases   #############
resource "google_compute_instance" "database" {
    count = 3
    name = "database${count.index+1}"
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

  tags = ["databases"]
}

resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tmpl", {
    balancer_names = google_compute_instance.balancer[*].name,
    balancer_ips = google_compute_instance.balancer[*].network_interface.0.access_config.0.nat_ip,
    adder_names = google_compute_instance.adder[*].name,
    adder_ips = google_compute_instance.adder[*].network_interface.0.access_config.0.nat_ip,
    multiplier_names = google_compute_instance.multiplier[*].name,
    multiplier_ips = google_compute_instance.multiplier[*].network_interface.0.access_config.0.nat_ip,
    frontend_names = google_compute_instance.frontend[*].name,
    frontend_ips = google_compute_instance.frontend[*].network_interface.0.access_config.0.nat_ip,
    database_names = google_compute_instance.database[*].name,
    database_ips = google_compute_instance.database[*].network_interface.0.access_config.0.nat_ip,
    monitor_name = google_compute_instance.monitor.name,
    monitor_ip = google_compute_instance.monitor.*.network_interface.0.access_config.0.nat_ip
  })
  filename = "inventory"
}