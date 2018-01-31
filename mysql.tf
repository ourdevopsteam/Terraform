resource "google_compute_instance" "mysql" {
   count        = "1"
   name         = "${var.network_name}-mysql"
   machine_type = "${var.instance_type_4}"
   zone         = "${local.gateway_zone}"
   
   boot_disk {
     initialize_params {
       image = "${var.centos_image}"
	   type = "pd-ssd"
       size = "50"
    }
  }
  
  network_interface {
    subnetwork = "${google_compute_subnetwork.private.self_link}"
  }

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  tags = ["${var.network_name}-privsnet","${var.network_name}-mysql","${var.network_name}-nat-instance"]
  
}