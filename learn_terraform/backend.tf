terraform {
  backend "s3" {
    bucket = "daniel-rodriguez-bucket"
    key    = "remote.tfstate"
    region = "us-east-2"
  }
}
