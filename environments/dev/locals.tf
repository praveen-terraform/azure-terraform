locals {
  environment = var.environment

  prefix_kebab = lower(replace(var.prefix, "_", "-"))
  hash_suffix  = var.name_suffix

  resource_group_name = "${local.prefix_kebab}-${local.hash_suffix}-rg"

  vnet_name = "${local.prefix_kebab}-${local.hash_suffix}-vnet"
  vm_name   = "${local.prefix_kebab}-${local.hash_suffix}-vm"

  tags = merge(
    var.tags,
    {
      Environment = local.environment
      ManagedBy   = "Terraform"
      Region      = var.location
      Workload    = "network-vm-demo"
    }
  )
}