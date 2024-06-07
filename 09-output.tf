output "k8s_cluster_external_ip" {
  description = "External IP of Kubernetes cluster"
  value       = var.k8s_cluster_public_ip ? yandex_kubernetes_cluster.k8s_cluster.master[0].external_v4_address : null
}

output "k8s_cluster_internal_ip" {
  description = "Internal IP of Kubernetes cluster"
  value       = yandex_kubernetes_cluster.k8s_cluster.master[0].internal_v4_address
}

output "k8s_cluster_external_connect_cmd" {
  description = "Command to connect to the Yandex Managed Kubernetes Cluster"
  value       = var.k8s_cluster_public_ip ? "yc managed-kubernetes cluster get-credentials --id ${yandex_kubernetes_cluster.k8s_cluster.id} --external" : null
}

output "k8s_cluster_internal_connect_cmd" {
  description = <<EOF
    Command to connect to the Yandex Managed Kubernetes Cluster.
    This cluster is available only from virtual machines in the same VPC as the cluster itself.
  EOF
  value       = var.k8s_cluster_public_ip == false ? "yc managed-kubernetes cluster get-credentials --id ${yandex_kubernetes_cluster.k8s_cluster.id} --internal" : null
}

output "k8s_cluster_ca_certificate" {
  description = "Kubernetes cluster certificate"
  value       = yandex_kubernetes_cluster.k8s_cluster.master[0].cluster_ca_certificate
}