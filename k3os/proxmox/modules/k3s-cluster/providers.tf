terraform {
  required_providers {
    remote = {
      source = "tenstad/remote"
      version = "0.0.23"
    }
  }
  experiments = [module_variable_optional_attrs]
}