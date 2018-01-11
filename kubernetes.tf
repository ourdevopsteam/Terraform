resource "google_container_cluster" "gcp_kubernetes" {
  name               = "testing"
  zone               = "asia-south1-b"
  initial_node_count = "2"

  additional_zones = [
    "asia-south1-a",
    "asia-south1-c",
  ]

  master_auth {
    username = "test"
    password = "test"
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]

    labels {
      this-is-for = "dev-cluster"
    }

    tags = ["dev", "work"]
  }
}
