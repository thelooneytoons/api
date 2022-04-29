terraform {
  backend "gcs" {
    bucket  = "the-looneytoons-tasks-bucket"
    prefix  = "terraform/state"
  }
}
