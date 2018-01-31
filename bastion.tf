
resource "google_compute_address" "bastion_box" {
	count = "1"
	name = "${var.network_name}-bastion-box"
}

data "template_file" "bastion_box_startup-script" {
  template = <<EOF
EOF
}

resource "google_compute_instance" "bastion_box" {
   count        = "1"
   name         = "${var.network_name}-bastion-box"
   machine_type = "${var.instance_type_1}"
   zone         = "${local.gateway_zone}"
   
   boot_disk {
     initialize_params {
       image = "${var.centos_image}"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.public.self_link}"

    access_config {
      nat_ip = "${google_compute_address.bastion_box.address}"
    }
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  tags = ["${var.network_name}-pubsnet","${var.network_name}-ssh","${var.network_name}-bastion"]
  
  metadata_startup_script = "${data.template_file.bastion_box_startup-script.rendered}"
   
}

resource "google_compute_firewall" "bastionbox" {
  count   = "1"
  name    = "${var.network_name}-bastionbox"
  network = "${google_compute_network.network.self_link}"

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
  }

  allow {
    protocol = "udp"
  }

  source_tags = ["${var.network_name}-bastion"]
  target_tags = ["${var.network_name}-privsnet"]
}

