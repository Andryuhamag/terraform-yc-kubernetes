module "network" {
  source              = "git@github.com:Andryuhamag/terraform-yc-network.git?ref=v0.1"
  network_name        = var.k8s_network_name
  network_description = var.k8s_network_description
  sg_name             = var.k8s_sg_name
  subnets             = var.k8s_subnets

}