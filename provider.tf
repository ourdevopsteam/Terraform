provider "google" {
    project     = "${var.gcp_project}"
    region      = "${var.gcp_region}"
	credentials = "${file("My First Project-2c922adc3797.json")}"
}


