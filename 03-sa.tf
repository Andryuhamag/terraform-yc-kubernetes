resource "yandex_iam_service_account" "k8s_resources_sa" {
  name      = "k8s-resources-sa"
  folder_id = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "k8s_clusters_agent" {
  folder_id = var.folder_id
  role      = "k8s.clusters.agent"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_resources_sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "vpc_publicadmin" {
  folder_id = var.folder_id
  role      = "vpc.publicAdmin"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_resources_sa.id}"
}

resource "yandex_resourcemanager_folder_iam_member" "load_balancer_admin" {
  folder_id = var.folder_id
  role      = "load-balancer.admin"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_resources_sa.id}"
}

resource "yandex_iam_service_account" "k8s_puller_sa" {
  name      = "k8s-puller-sa"
  folder_id = var.folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "cr_images_puller" {
  folder_id = var.folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.k8s_puller_sa.id}"
}
