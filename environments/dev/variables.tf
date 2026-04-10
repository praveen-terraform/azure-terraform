variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "prefix" {
  description = "Prefix for resource naming"
  type        = string
}

variable "name_suffix" {
  description = "Short unique suffix"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "tags" {
  description = "Base tags"
  type        = map(string)
}

variable "vnet_cidr" {
  description = "VNet CIDR block"
  type        = list(string)
}

variable "subnet_vm_cidr" {
  description = "VM subnet CIDR"
  type        = list(string)
}

variable "subnet_app_cidr" {
  description = "App subnet CIDR"
  type        = list(string)
}

variable "dns_servers" {
  description = "Custom DNS servers"
  type        = list(string)
  default     = []
}

variable "enable_ddos" {
  description = "Enable DDoS association"
  type        = bool
}

variable "ddos_protection_plan_id" {
  description = "Existing DDoS plan resource ID"
  type        = string
  default     = null
}

variable "vm_size" {
  description = "VM size"
  type        = string
}

variable "admin_username" {
  description = "VM admin username"
  type        = string
}

variable "public_key_path" {
  description = "Path to public SSH key"
  type        = string
}

variable "os_disk_size" {
  description = "OS disk size in GB"
  type        = number
}

variable "enable_security_features" {
  description = "Enable secure boot and vTPM"
  type        = bool
}

variable "availability_zone" {
  description = "Availability zone for VM resources"
  type        = string
}