terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider - updated 1.0
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "tf_test" {
  name     = "tfmainrg"
  location = "centralindia"
}
# Create a resource group for container and a container
resource "azurerm_container_group" "tfcg_test" {
  name = "weatherapis"
  location = azurerm_resource_group.tf_test.location
  resource_group_name = azurerm_resource_group.tf_test.name

  ip_address_type    = "Public"
  dns_name_label     = "azapiwi"
  os_type            = "Linux"

  
  container {
      name = "weatherapis"  
      image = "aqeelansari/weatherapis"
       cpu = "0.5"
       memory = "1.5"  

       ports {
         port = "80"
         protocol = "TCP"
       }
  }

}