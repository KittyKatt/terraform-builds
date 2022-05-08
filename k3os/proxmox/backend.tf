terraform {
  backend "s3" {
    bucket = "terraform-state-bohnenkk"
    key    = "state/k3os/proxmox/prod/terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "tfstate-prod"
  }
}
