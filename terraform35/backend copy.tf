terraform {
  backend "azurerm" {
    resource_group_name  = "practise-project35"
    storage_account_name = "terraform35"
    container_name       = "terraformbackend"
    key                  = "terraformbackend"
    access_key           = "hukigfHyh6CyIBS7cOXboJ2OZSbPX1BfbPqm9Qt8V8DU70TQfy1UvxvfDEb3u03IArQDacf4OOzg+ASteGutiw=="
  }
}