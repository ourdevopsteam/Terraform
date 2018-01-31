resource "google_sql_database_instance" "master" {
  name             = "${var.network_name}-mysql-google-1"
  project          = "${var.gcp_project}"
  region           = "${var.gcp_region}"
  database_version = "${var.database_version}"

  settings {
    tier                        = "${var.tier}"
    activation_policy           = "${var.activation_policy}"
    authorized_gae_applications = ["${var.authorized_gae_applications}"]
    disk_autoresize             = "${var.disk_autoresize}"
    backup_configuration        = ["${var.backup_configuration}"]
    ip_configuration            = ["${var.ip_configuration}"]
    location_preference         = ["${var.location_preference}"]
    maintenance_window          = ["${var.maintenance_window}"]
    disk_size                   = "${var.disk_size}"
    disk_type                   = "${var.disk_type}"
    pricing_plan                = "${var.pricing_plan}"
    replication_type            = "${var.replication_type}"
  }

  replica_configuration = ["${var.replica_configuration}"]
}

resource "google_sql_database" "default" {
  name      = "${var.db_name}"
  project   = "${var.gcp_project}"
  instance  = "${google_sql_database_instance.master.name}"
  charset   = "${var.db_charset}"
  collation = "${var.db_collation}"
}

resource "random_id" "user-password" {
  byte_length = 8
}

resource "google_sql_user" "default" {
  name     = "${var.user_name}"
  project  = "${var.gcp_project}"
  instance = "${google_sql_database_instance.master.name}"
  host     = "${var.user_host}"
  password = "${var.user_password == "" ? random_id.user-password.hex : var.user_password}"
}
