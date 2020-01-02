provider "kubernetes" {
}

resource "kubernetes_deployment" "client" {
  metadata {
    name = "client"
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        app = "client"
      }
    }
    min_ready_seconds = 15
    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = 1
        max_unavailable = 1
      }
    }
    template {
      metadata {
        labels = {
          app = "client"
        }
      }
      spec {
        container {
          image             = "client"
          name              = "client"
          image_pull_policy = "Never"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}
resource "kubernetes_deployment" "server" {
  metadata {
    name = "server"
  }
  spec {
    replicas = 3
    selector {
      match_labels = {
        app = "server"
      }
    }
    min_ready_seconds = 15
    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_surge       = 1
        max_unavailable = 1
      }
    }
    template {
      metadata {
        labels = {
          app = "server"
        }
      }
      spec {
        container {
          image             = "server"
          name              = "server"
          image_pull_policy = "Never"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "client-service" {
  metadata {
    name = "client-service"
  }
  spec {
    selector = {
      app = "client"
    }
    port {
      port        = 80
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
resource "kubernetes_service" "server-service" {
  metadata {
    name = "server-service"
  }
  spec {
    selector = {
      app = "server"
    }
    port {
      port        = 3000
      target_port = 3000
    }

    type = "LoadBalancer"
  }
}
