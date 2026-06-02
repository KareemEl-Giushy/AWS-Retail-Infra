terraform {
  backend "s3" {
    bucket       = "terraform-state-294936105594-us-east-1-an"
    key          = "state/terraform-state.tfstate"
    region       = "us-east-1"
    profile      = "kareem-aziz"
    use_lockfile = true
  }
}
