# instead of the latest version 2.5.2 terraform will now download 2.4.0 version of the plugin
terraform {
  required_providers {
    local = {
      source = "hashicorp/local"
      version = "2.4.0"

      # if we want to specificly as terraform to ask not to download a specific version
      # version =  "!= 2.5.2" 
      # So it now downloads the previous version available version 2.5.1

      # if we want terraform to use a version lesser/higher than a given version
      # we can use comparasion operators
      # version "< 2.4.0"
      # version "> 2.4.0"

      # we can also combine multipe comparison operators together.
      # version = "> 2.2.0, < 2.5.0 != 2.3.0"
    }
  }
}

provider "local" {
  # Configuration options
}