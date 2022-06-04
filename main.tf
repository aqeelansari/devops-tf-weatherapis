terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

terraform {
    backend "azurerm" {
        resource_group_name  = "tf_rg_blobstore"
        storage_account_name = "tfstorageeaccnt1"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}

variable "imagebuild" {
  type = string
  description = "Latest image build"
}
# Configure the Microsoft Azure Provider - updated 1.6
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "tf_test" {
  name     = "tfmainrg"
  location = "centralindia"
}

resource "azurerm_container_group" "tfcg_test" {
  name = "weatherapis"
  location = azurerm_resource_group.tf_test.location
  resource_group_name = azurerm_resource_group.tf_test.name

  ip_address_type    = "Public"
  dns_name_label     = "azapiwi"
  os_type            = "Linux"

  
  container {
      name = "weatherapis"  
      image = "aqeelansari/weatherapis:${var.imagebuild}"
       cpu = "0.5"
       memory = "1.5"  

       ports {
         port = "80"
         protocol = "TCP"
       }
  }

}