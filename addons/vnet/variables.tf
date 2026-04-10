variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "vnet_name" {
  description = "Name of the VNet"
  type        = string
}

variable "vnet_cidr" {
  description = "Address space used by the virtual network"
  type        = list(string)
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "dns_servers" {
  description = "Optional custom DNS servers"
  type        = list(string)
  default     = []
}

variable "enable_ddos" {
  description = "Enable DDoS protection plan association"
  type        = bool
  default     = false
}

variable "ddos_protection_plan_id" {
  description = "Existing DDoS protection plan ID"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
}

variable "subnets" {
  description = "Map of subnet definitions"
  type = map(object({
    subnet_address_prefix           = list(string)
    default_outbound_access_enabled = optional(bool, false)
    service_endpoints               = optional(list(string), [])
    private_endpoint_network_policies_enabled     = optional(bool, true)
    private_link_service_network_policies_enabled = optional(bool, true)

    delegation = optional(object({
      name = string
      service_delegation = object({
        name    = string
        actions = list(string)
      })
    }))

    rules = optional(list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = optional(string, "*")
      description                = optional(string, "")
    })), [])
  }))
}