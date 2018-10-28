variable name {}


resource "kubernetes_config_map" "hello-name" {
  metadata {
    name = "hello-name"
  }

  data {
    hello-name.yaml = "name: ${var.name}"
  }
}

resource "kubernetes_pod" "hello-name" {
  metadata {
    name = "hello-name-deployment"
    labels {
      App = "hello-name"
    }
  }

  spec {
    container {
      image = "kyuriy/hello-name:latest"
      name  = "hello-name"

      volume_mount {
        mount_path =  "/etc/config"
        name = "config-volume"
      }

      port {
        container_port = 8080
        protocol = "TCP"
      }
    }

    volume {
      name = "config-volume"
      config_map {
        name = "hello-name"
      }
    }
  }
}


resource "kubernetes_service" "hello-name" {
  metadata {
    name = "hello-name"
  }
  spec {
    selector {
      App = "${kubernetes_pod.hello-name.metadata.0.labels.App}"
    }
    port {
      port = 8080
      protocol = "TCP"
      target_port = 8080
    }

    type = "NodePort"
  }
}


