provider "google" {
    version = "3.5.0"
    #credentials = file("/downloads/compute-instance.json")
    project = "training-freshers"
    region = "us-central1"
    zone = "us-central1-c"
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

  metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y && echo '<!doctype html><html><body><h1>heyyy welcome to the looneytoons response<h2></h1></body></html> | /var/www/html/index.html"

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  // Apply the firewall rule to allow external IPs to access this instance
  #tags = ["web12345"]
}

#resource "google_compute_firewall" "web123456" {
#  name    = "default-allow-http"#  network = "default"
#
#  allow {
#    protocol = "tcp"
#    ports    = ["80", "8080"]
#  }
#
#  // Allow traffic from everywhere to instances with an http-server tag
#  source_ranges = ["0.0.0.0/0"]
#}

output "ip" {
  value = "${google_compute_instance.default.network_interface.0.access_config.0.nat_ip}"
}





