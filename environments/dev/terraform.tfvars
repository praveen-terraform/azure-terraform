subscription_id = "4152cb71-c857-4ded-a8ff-c5723e687cfa"

environment = "dev"
prefix      = "tfdev"
name_suffix = "01"

location = "East US"

tags = {
  Product   = "terraform-assignment"
  Owner     = "praveen"
  managedby = "terraform"
}

vnet_cidr       = ["10.10.0.0/16"]
subnet_vm_cidr  = ["10.10.1.0/24"]
subnet_app_cidr = ["10.10.2.0/24"]

dns_servers = []

enable_ddos             = false
ddos_protection_plan_id = null

vm_size                  = "Standard_B2s"
admin_username           = "azureuser"
public_key_path          = "~/.ssh/id_rsa.pub"
os_disk_size             = 30
enable_security_features = false
availability_zone        = "1"