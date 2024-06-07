#=========================== Provider variables ===========================#
variable "sa_key_file" {
  description = "Path to service account key file"
  type        = string
}
variable "cloud_id" {
  description = "The Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "The Folder ID"
  type        = string
}

#============================ Network variables ============================#
variable "k8s_network_name" {
  description = "Network name"
  type        = string
}

variable "k8s_network_description" {
  description = "Network description"
  type        = string
}

variable "k8s_sg_name" {
  description = "Security group name"
  type        = string
}

variable "k8s_subnets" {

  type = list(
    object(
      {
        name        = string,
        description = string,
        zone        = string,
        cidr        = list(string)
      }
    )
  )
}

#========================== k8s cluster variables ==========================#
variable "k8s_cluster_name" {
  description = "Name of Kubernetes cluster"
  type        = string
}

variable "k8s_cluster_description" {
  description = "Description of Kubernetes cluster"
  type        = string
}

variable "k8s_cluster_version" {
  description = "Version of Kubernetes master"
  type        = string
  default     = "1.29"
}

variable "k8s_cluster_zone" {
  type = string
}

variable "k8s_cluster_public_ip" {
  type    = bool
  default = false
}

variable "k8s_auto_upgrade" {
  description = "Boolean flag that specifies if master can be upgraded automatically"
  type        = bool
  default     = true
}

variable "k8s_maintenance_window" {

  type = map(any)
  default = {
    day        = "sunday"
    start_time = "15:00"
    duration   = "3h"
  }
}

variable "k8s_release_channel" {
  description = "Release channel of k8s cluster. RAPID, REGULAR or STABLE"
  type        = string
  default     = "REGULAR"
}

#========================== k8s node variables ==========================#
variable "k8s_node_group_name" {
  description = "Name of Kubernetes node group"
  type        = string
}

variable "k8s_node_group_description" {
  description = "Description of Kubernetes node group"
  type        = string
}

variable "k8s_node_nat" {
  type    = bool
  default = true
}

variable "k8s_node_auto_repair" {
  description = "Boolean flag that specifies if node group can be repaired automatically"
  type        = bool
  default     = true
}

variable "k8s_node_auto_upgrade" {
  description = "Boolean flag that specifies if master can be upgraded automatically"
  type        = bool
  default     = false
}

variable "k8s_node_maintenance_window" {

  type = map(any)
  default = {
    day        = "sunday"
    start_time = "19:00"
    duration   = "3h"
  }
}

variable "k8s_node_platform_id" {
  description = "The ID of the hardware platform configuration for the node group compute instances"
  type        = string
}

variable "k8s_node_cores" {
  description = "Cores"
  type        = number
  default     = 2
}

variable "k8s_node_core_fraction" {
  description = "Core fraction"
  type        = number
  default     = 20
}

variable "k8s_node_memory" {
  description = "RAM"
  type        = number
  default     = 2
}

variable "k8s_node_boot_disk_type" {
  type    = string
  default = "network-hdd"
}

variable "k8s_node_boot_disk_size" {
  type    = number
  default = 64
}

variable "k8s_node_scale_policy_initial" {
  type    = number
  default = 1
}

variable "k8s_node_scale_policy_min" {
  type    = number
  default = 1
}

variable "k8s_node_scale_policy_max" {
  type    = number
  default = 3
}
