terraform {
  required_providers {
    remote = {
      source = "tenstad/remote"
      version = "0.0.23"
    }
    http = {
      source = "terraform-aws-modules/http"
      version = "2.4.1"
    }
  }
  experiments = [module_variable_optional_attrs]
}
