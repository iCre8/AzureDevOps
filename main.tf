provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "main" {
  name     = "azure-demo-rg"
  location = var.location

  tags = {
    environment = "${var.UseTags}-tag"
  }
}

resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  address_space       = ["192.198.1.4/24"]
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    environment = "${var.UseTags}-tag"
  }
}

resource "azurerm_subnet" "internal" {
  name                 = "internal-sub-net"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["255.255.255.0/24"]

}

resource "azurerm_network_interface" "main" {
  name                = "${var.prefix}-nic"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }

  tags = {
    environment = "${var.UseTags}-tag"
  }

}

resource "azurerm_public_ip" "main" {
  name                = "${var.prefix}-Public-IP"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "${var.UseTags}-tag"
  }
}

resource "azurerm_lb" "main" {
  name                = "Project1LoadBalancer"
  location            = "West US"
  resource_group_name = azurerm_resource_group.main.name

  frontend_ip_configuration {
    name                 = "Project1LoadBalancerPublicIPAddress"
    public_ip_address_id = azurerm_public_ip.main.id
  }

  tags = {
    environment = "${var.UseTags}-tag"
  }

}

resource "azurerm_lb_backend_address_pool" "main" {
  resource_group_name = azurerm_resource_group.main.name
  loadbalancer_id     = azurerm_lb.main.id
  name                = "Project1BackEndLoadBalanceAddressPool"

}

resource "azurerm_network_security_group" "main"{
    name              = "${var.prefix}-project1-nsg"
    location          = azurerm_resource_group.main.location
    resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_network_security_rule" "http_deny-nsr" {
    network_security_group_name = "${var.prefix}-project1-nsg"
    name                           = "Deny http"
    resource_group_name            = "web-traffic-deny"
    protocol                       = "Tcp"
    access                         = "Deny"
    priority                       = 100
    direction                      = "Outbound"
    source_address_prefix          = "*"
    # source_address_prefixes        = "*" 
    source_port_range              = "80"
    # source_port_ranges             = ""
    # source_application_security_group_ids = azurerm_resource_group.main.id
    destination_address_prefix     = "*"
    # destination_address_prefixes   = "*"
    destination_port_range         = "80"
    # destination_port_ranges        = "*"
    # destination_application_security_group_ids = azurerm_resource_group.main.id
}

resource "azurerm_network_security_rule" "allow_internal_nsr" {
    network_security_group_name = "${var.prefix}-project1-nsg"
    name                           = "Allow Internal Traffic"
    resource_group_name            = "internal-traffic-allow"
    protocol                       = "Tcp"
    access                         = "Allow"
    priority                       = 101
    direction                      = "Inbound"
    source_address_prefix          = "*"
    # source_address_prefixes        = "*"
    source_port_range              = "*"
    # source_port_ranges             = "*"
    # source_application_security_group_ids = azurerm_resource_group.main.id
    destination_address_prefix     = "*"
    # destination_address_prefixes   = "*"
    destination_port_range         = "*"
    # destination_port_ranges        = "*"
    # destination_application_security_group_ids = azurerm_resource_group.main.id
}


resource "azurerm_availability_set" "main" {
  name                = "project1-ManagedAvailSet"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  tags = {
    environment = "${var.UseTags}-tag"
  }

}

resource "azurerm_linux_virtual_machine" "main" {

  count                           = "${var.vm_instances}"
  name                            = "${var.prefix}-vm"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  size                            = "Standard_B1s"
  admin_username                  = var.user_name
  admin_password                  = var.user_pass
  disable_password_authentication = false
  network_interface_ids = [ azurerm_network_interface.main.id ]

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  tags = {
    environment = "${var.UseTags}-tag"
    Name        = "Server ${count.index}"
  }
}