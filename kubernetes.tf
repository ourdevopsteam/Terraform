resource "google_container_node_pool" "container_cluster_node_pool" {
    name = "${var.network_name}-node"
    zone = "${local.gateway_zone}"
    node_count = "${var.node_count}"
	cluster = "${google_container_cluster.container_cluster.name}"
	
	node_config {
        machine_type = "${var.machine_type}"
        disk_size_gb = "${var.disk_size_gb}"
        local_ssd_count = "${var.local_ssd_count}"
        oauth_scopes = "${var.oauth_scopes}"
        tags = ["${var.network_name}-pubsnet", "${var.network_name}-microservices"]
    }
	
	autoscaling {
           min_node_count = "${var.minNodeCount_node}"
           max_node_count = "${var.maxNodeCount_node}"
    }

}

resource "google_container_cluster" "container_cluster" {
    name = "${var.network_name}-microservices"
    zone = "${local.gateway_zone}"
    initial_node_count = "${var.cluster_count}"
    additional_zones = "${var.additional_zones}"
    network = "${var.network_name}"
    subnetwork = "${google_compute_subnetwork.public.self_link}"

	master_auth {
        username = "${var.username}"
        password = "${var.password}"
    }
	
    addons_config {
        http_load_balancing {
            disabled = "${var.http_load_balancing_disable}"
        }

        horizontal_pod_autoscaling {
            disabled = "${var.horizontal_pod_autoscaling_disable}"
        }
		
		kubernetes_dashboard {
            disabled = "${var.disable_dashboard}"
        }
	 
    }
   
   		
}