resource "google_compute_firewall" "privatesubnet" {
	name = "${var.network_name}-local-privsnet"
	network = "${google_compute_network.network.name}"
	
    allow {
        protocol = "tcp"
        ports = ["1-65535"]
    }	

    allow {
        protocol = "udp"
        ports = ["1-65535"]
    }
	
	allow {
	    protocol = "icmp"
	}
	source_tags = ["${var.network_name}-privsnet"]
	target_tags = ["${var.network_name}-privsnet"]
}

resource "google_compute_firewall" "publicsubnet" {
	name = "${var.network_name}-local-pubsnet"
	network = "${google_compute_network.network.name}"
	
    allow {
        protocol = "tcp"
        ports = ["1-65535"]
    }	

    allow {
        protocol = "udp"
        ports = ["1-65535"]
    }
	
	allow {
	    protocol = "icmp"
	}
	source_tags = ["${var.network_name}-pubsnet"]
	target_tags = ["${var.network_name}-pubsnet"]
}

resource "google_compute_firewall" "http" {
    name = "${var.network_name}-http"
    network = "${google_compute_network.network.name}"

    allow {
        protocol = "tcp"
        ports = ["80"]
    }

    source_ranges = ["0.0.0.0/0"]
    target_tags = ["${var.network_name}-http"]
}

resource "google_compute_firewall" "https" {
    name = "${var.network_name}-https"
    network = "${google_compute_network.network.name}"

    allow {
        protocol = "tcp"
        ports = ["443"]
    }

    source_ranges = ["0.0.0.0/0"]
    target_tags = ["${var.network_name}-https"]
}

resource "google_compute_firewall" "ssh" {
    name = "${var.network_name}-ssh"
    network = "${google_compute_network.network.name}"

    allow {
        protocol = "tcp"
        ports = ["22"]
    }

    source_ranges = ["0.0.0.0/0"]
    target_tags = ["${var.network_name}-ssh"]
}
