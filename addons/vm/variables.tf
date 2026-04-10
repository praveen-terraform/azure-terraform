variable "name" {
  description = "VM name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for VM NIC"
  type        = string
}

variable "vm_size" {
  description = "Azure VM size"
  type        = string
}

variable "admin_username" {
  description = "Admin username for VM"
  type        = string
}

variable "public_key_path" {
  description = "Path to SSH public key"
  type        = string
}

variable "os_disk_size" {
  description = "OS disk size in GB"
  type        = number
}

variable "enable_security_features" {
  description = "Enable secure boot and vTPM"
  type        = bool
  default     = false
}

variable "zone" {
  description = "Availability zone"
  type        = string
  default     = "1"
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
}