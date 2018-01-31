// Network Creation

resource "google_compute_network" "network" {
   name  = "${var.network_name}"
   auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public" {
  count                    = "1"
  name                     = "${var.network_name}-public"
  ip_cidr_range            = "${var.public_subnet}"
  network                  = "${google_compute_network.network.self_link}"
  region                   = "${var.gcp_region}"
  private_ip_google_access = "${var.subnetwork_private_ip_google_access}"
}

resource "google_compute_subnetwork" "private" {
  count                    = "1"
  name                     = "${var.network_name}-private"
  ip_cidr_range            = "${var.private_subnet}"
  network                  = "${google_compute_network.network.self_link}"
  region                   = "${var.gcp_region}"
  private_ip_google_access = "${var.subnetwork_private_ip_google_access}"
}

data "google_compute_zones" "available" {}

locals { 
  gateway_zone   = "${element(data.google_compute_zones.available.names, 1)}"
}


resource "google_compute_address" "nat_gateway" {
  count = "1"
  name  = "${var.network_name}-nat-gateway"
}


resource "google_compute_instance" "nat_gateway" {
  count        = "1"
  name         = "${var.network_name}-nat-gateway"
  machine_type = "${var.instance_type_1}"
  zone         = "${local.gateway_zone}"

  can_ip_forward = true

  boot_disk {
    initialize_params {
      image = "${var.centos_image}"
    }
  }

  network_interface {
    subnetwork = "${google_compute_subnetwork.public.self_link}"

    access_config {
      nat_ip = "${google_compute_address.nat_gateway.address}"
    }
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  metadata_startup_script = <<EOF
echo 1 > /proc/sys/net/ipv4/ip_forward
${var.nat_gateway_iptables}
EOF

  tags = ["${var.network_name}-pubsnet","${var.network_name}-nat-gateway","${var.network_name}-ssh"]
  
}


resource "google_compute_route" "default_route" {
  count                  = "1"
  name                   = "${var.network_name}-to-nat-gateway"
  dest_range             = "0.0.0.0/0"
  network                = "${google_compute_network.network.self_link}"
  next_hop_instance      = "${google_compute_instance.nat_gateway.name}"
  next_hop_instance_zone = "${local.gateway_zone}"
  tags                   = ["${var.network_name}-nat-instance"]
  priority               = 100
  depends_on             = ["google_compute_instance.nat_gateway"]
}

resource "google_compute_firewall" "nat_to_gateway" {
  count   = "1"
  name    = "${var.network_name}-nat-to-gateway"
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

  source_tags = ["${var.network_name}-nat-instance"]

  target_tags = ["${var.network_name}-nat-gateway"]
    
}