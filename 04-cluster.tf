resource "yandex_kubernetes_cluster" "k8s_zonal_cluster" {
  name        = var.k8s_cluster_name
  description = var.k8s_cluster_description
  network_id  = module.network.network_id

  master {
    version = var.k8s_cluster_version
    zonal {
      zone      = var.k8s_cluster_zone
      subnet_id = lookup({ for mapItem in module.network.subnets_info : mapItem.zone => mapItem.subnet_id }, var.k8s_cluster_zone, null)
    }
    public_ip = var.k8s_cluster_public_ip
    security_group_ids = [
      "${module.network.sg_id}"
    ]
    maintenance_policy {
      auto_upgrade = var.k8s_auto_upgrade
      maintenance_window {
        day        = var.k8s_maintenance_window.day
        start_time = var.k8s_maintenance_window.start_time
        duration   = var.k8s_maintenance_window.duration
      }
    }
  }

  service_account_id      = yandex_iam_service_account.k8s_resources_sa.id
  node_service_account_id = yandex_iam_service_account.k8s_puller_sa.id
  release_channel         = var.k8s_release_channel

  depends_on = [
    yandex_resourcemanager_folder_iam_member.k8s_clusters_agent,
    yandex_resourcemanager_folder_iam_member.vpc_publicadmin,
    yandex_resourcemanager_folder_iam_member.load_balancer_admin,
    yandex_resourcemanager_folder_iam_member.cr_images_puller
  ]
}

resource "yandex_kubernetes_node_group" "k8s_node_group" {
  cluster_id  = yandex_kubernetes_cluster.k8s_zonal_cluster.id
  name        = var.k8s_node_group_name
  description = var.k8s_node_group_description
  version     = var.k8s_cluster_version

  instance_template {
    platform_id = var.k8s_node_platform_id

    network_interface {
      nat = var.k8s_node_nat
      subnet_ids = [
        lookup({ for mapItem in module.network.subnets_info : mapItem.zone => mapItem.subnet_id }, var.k8s_cluster_zone, null)
      ]
    }

    resources {
      cores         = var.k8s_node_cores
      core_fraction = var.k8s_node_core_fraction
      memory        = var.k8s_node_memory
    }

    boot_disk {
      type = var.k8s_node_boot_disk_type
      size = var.k8s_node_boot_disk_size
    }
  }

  scale_policy {
    auto_scale {
      initial = var.k8s_node_scale_policy_initial
      min     = var.k8s_node_scale_policy_min
      max     = var.k8s_node_scale_policy_max
    }
  }

  allocation_policy {
    location {
      zone = var.k8s_cluster_zone
    }
  }

  maintenance_policy {
    auto_upgrade = var.k8s_node_auto_upgrade
    auto_repair  = var.k8s_node_auto_repair
    maintenance_window {
      day        = var.k8s_node_maintenance_window.day
      start_time = var.k8s_node_maintenance_window.start_time
      duration   = var.k8s_node_maintenance_window.duration
    }
  }
}