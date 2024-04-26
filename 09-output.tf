output "command_to_connect_to_k8s_cluster" {
  value = "yc managed-kubernetes cluster get-credentials --id ${yandex_kubernetes_cluster.k8s_zonal_cluster.id} --external"
}
