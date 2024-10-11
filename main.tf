provider "google" {
project = "primal-gear-436812-t0"
region = "us-central1"
zone = "us-central1-a"
}

resource "google_compute_instance" "default" {
 name = "tsunade"
 machine_type = "e2-medium"

 # Boot disk image for CentOS 9
  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-stream-9"
    }
  }


  network_interface {
    network = "default"
    access_config {
    }
  }

provisioner "file" {
  source = "/home/hr376/sample.sh"
  destination = "/tmp/shell_script.sh"

  connection {
    type = "ssh"
    user = "hr376"
    private_key = file("/home/hr376/.ssh/id_rsa")
    host        = self.network_interface[0].access_config[0].nat_ip
  }
}

}



