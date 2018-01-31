// Project Variables 

variable "gcp_project" {
     description = "The project to deploy to, if not set the default provider project is used."
     default     = "test"
}

variable "gcp_region" {
     description = "Region for cloud resources."
     default     = "asia-south1"
}

variable "network_name" {
     description = "Name of the VPC network"
     default = "production"
}

variable "public_subnet" {
  description = "Subnetwork CIDR block in which to create the Public Subnet"
  default     = "10.0.0.0/24"
}

variable "private_subnet" {
  description = "Subnetwork CIDR block in which to create the Private Subnet"
  default     = "10.0.1.0/24"
}

variable "subnetwork_private_ip_google_access" {
     default = true
     description = "Whether the VMs in subnets can access Google services without assigned external IP addresses"

}

variable "instance_type_4" {
  description = "GCE instance type 4"
  default     = "n1-standard-4"
}

variable "instance_type_1" {
  description = "GCE instance type 1"
  default     = "n1-standard-1"
}

variable "instance_type_2" {
  description = "GCE instance type 2"
  default     = "n1-standard-2"
}

variable "centos_image" {
    description = "GCE instance image centos"
    default     = "centos-cloud/centos-7"
}

variable "nat_gateway_iptables" {
  description = "A set of instructions (one per line) used as metadata script and defining the iptables routing configuration"

  default = <<EOF
iptables -t nat -A POSTROUTING -j MASQUERADE
EOF
}

variable "gce_ssh_user" {
  default = "sapient_common_gcp"
}

variable "gce_ssh_pub_key_file" {
  default = ".google_compute_engine.pub"
}

#### Google Container Cluster #####

variable "cluster_count" {
    type = "string"
    default = 3
    description = "The number of nodes to create in this cluster (not including the Kubernetes master)"
}

variable "additional_zones" {
    type = "list"
    default = []
    description = "If additional zones are configured, the number of nodes specified in initial_node_count is created in all specified zones"
}

variable "machine_type" {
    type = "string"
    default = "n1-standard-4"
    description = "The name of a Google Compute Engine machine type"
}

variable "disk_size_gb" {
    type = "string"
    default = 300
    description = "Size of the disk attached to each node, specified in GB"
}

variable "local_ssd_count" {
    type = "string"
    default = 0
    description = " The amount of local SSD disks that will be attached to each cluster node"
}

variable "oauth_scopes" {
    type = "list"
    default = [
        "https://www.googleapis.com/auth/compute",
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
    ]
    description = "The set of Google API scopes to be made available on all of the node VMs under the default service account"
}
  


// Auth API K8S

variable "username" {
    type = "string"
    description = "The username to use for HTTP basic authentication when accessing the Kubernetes master endpoint"
	default = "admin"
}

variable "password" {
    type = "string"
    description = "The password to use for HTTP basic authentication when accessing the Kubernetes master endpoint"
	default = "mysecretpassword"
}

variable "bastion_user" {
    type = "string"
	default = "sapient_common_gcp_gmail_com"
}


// Auto-scaling

variable "http_load_balancing_disable" {
    type = "string"
    default = false
    description = "The status of the HTTP Load Balancing add-on"
}

variable "horizontal_pod_autoscaling_disable" {
    type = "string"
    default = true
    description = "The status of the Horizontal Pod Autoscaling addon"
}

variable "disable_dashboard" {
  description = "Whether the Kubernetes Dashboard should be disabled"
  default     = false
}

variable "disable_autoscaling_addon" {
  description = "Whetherthe Autoscaling Pod addon should be disabled"
  default     = false
}

// Nodes

variable "node_count" {
    type = "string"
    default = 3
    description = "The initial node count for the pool"
}

variable "machine_type_node" {
    type = "string"
    default = "n1-standard-4"
    description = "The name of a Google Compute Engine machine type"
}

variable "disk_size_gb_node" {
    type = "string"
    default = 300
    description = "Size of the disk attached to each node, specified in GB"
}

variable "local_ssd_count_node" {
    type = "string"
    default = 0
    description = "The amount of local SSD disks that will be attached to each node pool"
}


// Node Autoscale

variable "minNodeCount_node" {
    type = "string"
    default = 3
    description = "Minimum number of nodes in the NodePool"
}

variable "maxNodeCount_node" {
    type = "string"
    default = 6
    description = "Maximum number of nodes in the NodePool"
}

// Google DB
variable project {
  description = "The project to deploy to, if not set the default provider project is used."
  default     = ""
}

variable region {
  description = "Region for cloud resources"
  default     = "us-central1"
}

variable name {
  description = "Name for the database instance. Must be unique and cannot be reused for up to one week."
  default = "mysql"
}

variable database_version {
  description = "The version of of the database. For example, `MYSQL_5_6` or `POSTGRES_9_6`."
  default     = "MYSQL_5_6"
}

variable tier {
  description = "The machine tier (First Generation) or type (Second Generation). See this page for supported tiers and pricing: https://cloud.google.com/sql/pricing"
  default     = "db-f1-micro"
}

variable db_name {
  description = "Name of the default database to create"
  default     = "default"
}

variable db_charset {
  description = "The charset for the default database"
  default     = ""
}

variable db_collation {
  description = "The collation for the default database. Example for MySQL databases: 'utf8', and Postgres: 'en_US.UTF8'"
  default     = ""
}

variable user_name {
  description = "The name of the default user"
  default     = "default"
}

variable user_host {
  description = "The host for the default user"
  default     = "%"
}

variable user_password {
  description = "The password for the default user. If not set, a random one will be generated and available in the generated_user_password output variable."
  default     = ""
}

variable activation_policy {
  description = "This specifies when the instance should be active. Can be either `ALWAYS`, `NEVER` or `ON_DEMAND`."
  default     = "ALWAYS"
}

variable authorized_gae_applications {
  description = "A list of Google App Engine (GAE) project names that are allowed to access this instance."
  type        = "list"
  default     = []
}

variable disk_autoresize {
  description = "Second Generation only. Configuration to increase storage size automatically."
  default     = true
}

variable disk_size {
  description = "Second generation only. The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased."
  default     = 10
}

variable disk_type {
  description = "Second generation only. The type of data disk: `PD_SSD` or `PD_HDD`."
  default     = "PD_SSD"
}

variable pricing_plan {
  description = "First generation only. Pricing plan for this instance, can be one of `PER_USE` or `PACKAGE`."
  default     = "PER_USE"
}

variable replication_type {
  description = "Replication type for this instance, can be one of `ASYNCHRONOUS` or `SYNCHRONOUS`."
  default     = "SYNCHRONOUS"
}

variable backup_configuration {
  description = "The backup_configuration settings subblock for the database setings"
  type        = "map"
  default     = {}
}

variable ip_configuration {
  description = "The ip_configuration settings subblock"
  type        = "list"
  default     = [{}]
}

variable location_preference {
  description = "The location_preference settings subblock"
  type        = "list"
  default     = []
}

variable maintenance_window {
  description = "The maintenance_window settings subblock"
  type        = "list"
  default     = []
}

variable replica_configuration {
  description = "The optional replica_configuration block for the database instance"
  type        = "list"
  default     = []
}
