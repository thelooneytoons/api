

provider "google" {
    version = "3.5.0"
  
    project = "thelooneytoons-tasks"
    region = "us-central1"
    zone = "us-central1-c"
}




 resource "google_compute_address" "static-dvs" {
   project      =  "thelooneytoons-tasks" # Replace this with your service project ID in quotes
   name         = "ipv4-address"
   address_type = "EXTERNAL"
 }




resource "google_compute_instance" "default" {
  name         = "thelooneytoons2"
  machine_type = "f1-micro"
  zone         = "us-central1-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  metadata_startup_script = "apt-get update; mkdir new; apt-get install python-pip git -y; git clone https://github.com/thelooneytoons/api.git && cd api; pip install -r requirements.txt; python api.py"

  network_interface {
    network = "default"

    access_config {
       nat_ip = google_compute_address.static-dvs.address
    }
  }
    tags= ["http-server"]
}






