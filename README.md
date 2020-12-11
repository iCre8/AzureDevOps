
## Deploying scalable IaaS web server in Azure

### Overview
Terraform and Packer templates are used to deploy a customizable, scalable web server in Azure using the Azure-CLI.
Knowledge of configure windows environmental variables is useful but not neccessary. 

### Getting Started
1. Create a free [Azure Account](https://portal.azure.com/)
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)
5. Clone this repo
6. Your favorite IDE

### Instructions
Once you've created your Azure account and installed Terraform and Packer. You can buld and deploy the infrastructure to the cloud following the steps below. The script will prompt you for user name and passwords to the machines you deploy. It will also ask how many virtual machines should be deployed. the `vars.tf` file has been used to create dynamic login. 

### Configuring using input
You can modify this file to add your own variable. 
each variable in `vars.tf` should have a description and can have a default value. if no default value is given, you will be prompted for input during the script execution.
Notes

The file `vars.tf` contains definitions for variables used by Terrafrom. This file provides descriptions of the purpose of each variable as well default values. The values of variables can be modified in the command line when calling `terraform apply` or `terraform plan`, i.e. `terraform plan -var 'vm_instances=1'`. The default `vm_instaces` variable is set to 2. 

1. Clone this repository
2. Navigate to the cloned repository 
3. Open the source code in your favorite editor 
4. Navigate to the templates folders 
5. Run `Packer validate packer.json`
6. Run `Packer build -var your_azure_subscription_id packer.json`
7. Run `Terraform plan -out tf-webserver.plan`
8. Run `Terraform apply` 

### Once you logged into the Azure portal and reviewed the deployment: 
Run `Terraform destroy` to remove the infrastructure

### Output
Packer will create assest for the images you deploy. 
Terraform will create a plan that can be used to deploy to Azure. Review the output from `Terrafomr plan -out` to review the planned infrastructure deployment.

`An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_availability_set.project_1_avail_set will be created
  + resource "azurerm_availability_set" "project_1_avail_set" {
      + id                           = (known after apply)
      + location                     = "eastus"
      + managed                      = true
      + name                         = "tf-packer-project-1"
      + platform_fault_domain_count  = 3
      + platform_update_domain_count = 5
      + resource_group_name          = "project-1-rg"
      + tags                         = {
          + "project_1" = "Terraform, Packer  Web Server Deployment"
        }
    }

  # azurerm_lb.project_1_lb[0] will be created
  + resource "azurerm_lb" "project_1_lb" {
      + id                   = (known after apply)
      + location             = "eastus"
      + name                 = "tf-packer-project-1-LoadBalancer"
      + private_ip_address   = (known after apply)
      + private_ip_addresses = (known after apply)
      + resource_group_name  = "project-1-rg"
      + sku                  = "Basic"
      + tags                 = {
          + "project_1" = "Terraform, Packer  Web Server Deployment"
        }

      + frontend_ip_configuration {
          + id                            = (known after apply)
          + inbound_nat_rules             = (known after apply)
          + load_balancer_rules           = (known after apply)
          + name                          = "pub-ip-lb-0"
          + outbound_rules                = (known after apply)
          + private_ip_address            = (known after apply)
          + private_ip_address_allocation = (known after apply)
          + private_ip_address_version    = "IPv4"
          + public_ip_address_id          = (known after apply)
          + public_ip_prefix_id           = (known after apply)
          + subnet_id                     = (known after apply)
        }
    }

  # azurerm_lb.project_1_lb[1] will be created
  + resource "azurerm_lb" "project_1_lb" {
      + id                   = (known after apply)
      + location             = "eastus"
      + name                 = "tf-packer-project-1-LoadBalancer"
      + private_ip_address   = (known after apply)
      + private_ip_addresses = (known after apply)
      + resource_group_name  = "project-1-rg"
      + sku                  = "Basic"
      + tags                 = {
          + "project_1" = "Terraform, Packer  Web Server Deployment"
        }

      + frontend_ip_configuration {
          + id                            = (known after apply)
          + inbound_nat_rules             = (known after apply)
          + load_balancer_rules           = (known after apply)
          + name                          = "pub-ip-lb-1"
          + outbound_rules                = (known after apply)
          + private_ip_address            = (known after apply)
          + private_ip_address_allocation = (known after apply)
          + private_ip_address_version    = "IPv4"
          + public_ip_address_id          = (known after apply)
          + public_ip_prefix_id           = (known after apply)
          + subnet_id                     = (known after apply)
        }
    }

  # azurerm_lb_backend_address_pool.project_1_lb_backend[0] will be created
  + resource "azurerm_lb_backend_address_pool" "project_1_lb_backend" {
      + backend_ip_configurations = (known after apply)
      + id                        = (known after apply)
      + load_balancing_rules      = (known after apply)
      + loadbalancer_id           = (known after apply)
      + name                      = "project_1_lb_backend-0"
      + resource_group_name       = "project-1-rg"
    }

  # azurerm_lb_backend_address_pool.project_1_lb_backend[1] will be created
  + resource "azurerm_lb_backend_address_pool" "project_1_lb_backend" {
      + backend_ip_configurations = (known after apply)
      + id                        = (known after apply)
      + load_balancing_rules      = (known after apply)
      + loadbalancer_id           = (known after apply)
      + name                      = "project_1_lb_backend-1"
      + resource_group_name       = "project-1-rg"
    }

  # azurerm_linux_virtual_machine.project_1_vm[0] will be created
  + resource "azurerm_linux_virtual_machine" "project_1_vm" {
      + admin_password                  = (sensitive value)
      + admin_username                  = (sensitive)
      + allow_extension_operations      = true
      + computer_name                   = (known after apply)
      + disable_password_authentication = false
      + extensions_time_budget          = "PT1H30M"
      + id                              = (known after apply)
      + location                        = "eastus"
      + max_bid_price                   = -1
      + name                            = "packer-linux-vm-B1s-0"
      + network_interface_ids           = (known after apply)
      + priority                        = "Regular"
      + private_ip_address              = (known after apply)
      + private_ip_addresses            = (known after apply)
      + provision_vm_agent              = true
      + public_ip_address               = (known after apply)
      + public_ip_addresses             = (known after apply)
      + resource_group_name             = "project-1-rg"
      + size                            = "Standard_B1s"
      + source_image_id                 = "/subscriptions/c2669e0a-34a5-40d0-a3c3-08858cb49a53/resourceGroups/udacity-project-1/providers/Microsoft.Compute/images/packer-ubuntu-image"
      + tags                            = {
          + "project_1" = "Terraform, Packer  Web Server Deployment"
        }
      + virtual_machine_id              = (known after apply)
      + zone                            = (known after apply)

      + os_disk {
          + caching                   = "ReadWrite"
          + disk_size_gb              = (known after apply)
          + name                      = (known after apply)
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }
    }

  # azurerm_linux_virtual_machine.project_1_vm[1] will be created
  + resource "azurerm_linux_virtual_machine" "project_1_vm" {
      + admin_password                  = (sensitive value)
      + admin_username                  = (sensitive)
      + allow_extension_operations      = true
      + computer_name                   = (known after apply)
      + disable_password_authentication = false
      + extensions_time_budget          = "PT1H30M"
      + id                              = (known after apply)
      + location                        = "eastus"
      + max_bid_price                   = -1
      + name                            = "packer-linux-vm-B1s-1"
      + network_interface_ids           = (known after apply)
      + priority                        = "Regular"
      + private_ip_address              = (known after apply)
      + private_ip_addresses            = (known after apply)
      + provision_vm_agent              = true
      + public_ip_address               = (known after apply)
      + public_ip_addresses             = (known after apply)
      + resource_group_name             = "project-1-rg"
      + size                            = "Standard_B1s"
      + source_image_id                 = "/subscriptions/c2669e0a-34a5-40d0-a3c3-08858cb49a53/resourceGroups/udacity-project-1/providers/Microsoft.Compute/images/packer-ubuntu-image"
      + tags                            = {
          + "project_1" = "Terraform, Packer  Web Server Deployment"
        }
      + virtual_machine_id              = (known after apply)
      + zone                            = (known after apply)

      + os_disk {
          + caching                   = "ReadWrite"
          + disk_size_gb              = (known after apply)
          + name                      = (known after apply)
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }
    }

  # azurerm_network_interface.project_1_nic[0] will be created
  + resource "azurerm_network_interface" "project_1_nic" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "eastus"
      + mac_address                   = (known after apply)
      + name                          = "tf-packer-project-1-nic-0"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "project-1-rg"
      + tags                          = {
          + "project_1" = "Terraform, Packer  Web Server Deployment"
        }
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + name                          = "tf-packer-project-1-internal-0"
          + primary                       = (known after apply)
          + private_ip_address            = (known after apply)
          + private_ip_address_allocation = "dynamic"
          + private_ip_address_version    = "IPv4"
          + subnet_id                     = (known after apply)
        }
    }

  # azurerm_network_interface.project_1_nic[1] will be created
  + resource "azurerm_network_interface" "project_1_nic" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "eastus"
      + mac_address                   = (known after apply)
      + name                          = "tf-packer-project-1-nic-1"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "project-1-rg"
      + tags                          = {
          + "project_1" = "Terraform, Packer  Web Server Deployment"
        }
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + name                          = "tf-packer-project-1-internal-1"
          + primary                       = (known after apply)
          + private_ip_address            = (known after apply)
          + private_ip_address_allocation = "dynamic"
          + private_ip_address_version    = "IPv4"
          + subnet_id                     = (known after apply)
        }
    }

  # azurerm_network_security_group.project_1_nsg will be created
  + resource "azurerm_network_security_group" "project_1_nsg" {
      + id                  = (known after apply)
      + location            = "eastus"
      + name                = "tf-packer-project-1-project1-nsg"
      + resource_group_name = "project-1-rg"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = "VirtualNetwork"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "*"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "allow-virtual-network-inbound"
              + priority                                   = 201
              + protocol                                   = "*"
              + source_address_prefix                      = "VirtualNetwork"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = "VirtualNetwork"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "*"
              + destination_port_ranges                    = []
              + direction                                  = "Outbound"
              + name                                       = "allow-virtual-network-outbound"
              + priority                                   = 200
              + protocol                                   = "*"
              + source_address_prefix                      = "VirtualNetwork"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
          + {
              + access                                     = "Deny"
              + description                                = ""
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "*"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "deny-Inbound-web-traffic"
              + priority                                   = 205
              + protocol                                   = "*"
              + source_address_prefix                      = "*"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
          + {
              + access                                     = "Deny"
              + description                                = ""
              + destination_address_prefix                 = "*"
              + destination_address_prefixes               = []
              + destination_application_security_group_ids = []
              + destination_port_range                     = "*"
              + destination_port_ranges                    = []
              + direction                                  = "Outbound"
              + name                                       = "deny-outbound-web-traffic"
              + priority                                   = 210
              + protocol                                   = "*"
              + source_address_prefix                      = "*"
              + source_address_prefixes                    = []
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
        ]
    }

  # azurerm_public_ip.project_1_pub_ip[0] will be created
  + resource "azurerm_public_ip" "project_1_pub_ip" {
      + allocation_method       = "Dynamic"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "eastus"
      + name                    = "tf-packer-project-1-0"
      + resource_group_name     = "project-1-rg"
      + sku                     = "Basic"
      + tags                    = {
          + "project_1" = "Terraform, Packer  Web Server Deployment"
        }
    }

  # azurerm_public_ip.project_1_pub_ip[1] will be created
  + resource "azurerm_public_ip" "project_1_pub_ip" {
      + allocation_method       = "Dynamic"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "eastus"
      + name                    = "tf-packer-project-1-1"
      + resource_group_name     = "project-1-rg"
      + sku                     = "Basic"
      + tags                    = {
          + "project_1" = "Terraform, Packer  Web Server Deployment"
        }
    }

  # azurerm_resource_group.project_1_rg will be created
  + resource "azurerm_resource_group" "project_1_rg" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = "project-1-rg"
      + tags     = {
          + "project_1" = "Terraform, Packer  Web Server Deployment"
        }
    }

  # azurerm_subnet.project_1_subnet will be created
  + resource "azurerm_subnet" "project_1_subnet" {
      + address_prefix                                 = (known after apply)
      + address_prefixes                               = [
          + "10.0.2.0/24",
        ]
      + enforce_private_link_endpoint_network_policies = false
      + enforce_private_link_service_network_policies  = false
      + id                                             = (known after apply)
      + name                                           = "tf-packer-project-1-internal-sub-net"
      + resource_group_name                            = "project-1-rg"
      + virtual_network_name                           = "tf-packer-project-1-network"
    }

  # azurerm_virtual_network.project_1_vn will be created
  + resource "azurerm_virtual_network" "project_1_vn" {
      + address_space         = [
          + "10.0.0.0/16",
        ]
      + guid                  = (known after apply)
      + id                    = (known after apply)
      + location              = "eastus"
      + name                  = "tf-packer-project-1-network"
      + resource_group_name   = "project-1-rg"
      + subnet                = (known after apply)
      + tags                  = {
          + "project_1" = "Terraform, Packer  Web Server Deployment"
        }
      + vm_protection_enabled = false
    }
    `
