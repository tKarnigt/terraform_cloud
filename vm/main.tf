provider "google" {
  credentials = file("sa-key.json")
  project     = "terraform-project-437716"
  region      = "asia-southeast1"
}

resource "google_compute_firewall" "allow_ssh_http" {
  name    = "allow-ssh-http"
  network = "default"  

  allow {
    protocol = "tcp"
    ports    = ["22", "80"]  
  }

  source_ranges = ["0.0.0.0/0"] 
}

resource "google_compute_instance" "vm" {
  name         = "terraform-instance"
  zone         = "asia-southeast1-a"
  machine_type = "n2-standard-2"

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-jammy-v20240927"
    }
  }

  network_interface {
    network = "default"  
    access_config {}     
  }
}
