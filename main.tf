provider "google" {
  credentials = file("sa-key.json")     
  project     = "terraform-project-437716"    
  region      = "asia-southeast1"             
}

resource "google_compute_instance" "confidential_instance" {
  name             = "my-confidential-instance"
  zone             = "asia-southeast1-a"
  machine_type     = "n2d-standard-2"

  confidential_instance_config {
    enable_confidential_compute = true
    confidential_instance_type  = "SEV"
  }

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
      labels = {
        my_label = "value"
      }
    }
  }

  // Local SSD disk
  scratch_disk {
    interface = "NVME"
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }
}