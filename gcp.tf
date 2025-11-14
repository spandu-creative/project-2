resource "google_compute_instance" "gcp_web" {
  name         = "gcp-web"
  machine_type = "e2-micro"
  zone         = var.gcp_zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt update
    apt install -y nginx
    echo "<h1>Welcome to GCP Server</h1>" > /var/www/html/index.html
  EOF
}

output "gcp_public_ip" {
  value = google_compute_instance.gcp_web.network_interface[0].access_config[0].nat_ip
}
