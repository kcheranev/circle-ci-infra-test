provider "kubernetes" {
  insecure = true
  token = var.token
  host = var.k8s_host
}

resource "kubernetes_deployment" "circle-ci-test" {
  metadata {
    name = "circle-ci-test"
    labels = {
      app = "circle-ci-test"
    }
  }
  spec {
    replicas = 2
    selector {
      match_expressions {
        key = "mcs.mail.ru/mcs-nodepool"
        operator = "In"
        values = [
          "default-group"
        ]
      }
      match_labels = {
        app = "circle-ci-test"
      }
    }
    template {
      metadata {
        labels = {
          app = "circle-ci-test"
        }
      }
      spec {
        container {
          image = "diblack/circle-ci-test:${var.circle-ci-test__version}"
          name = "circle-ci-test"
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "circle-ci-test" {
  metadata {
    name = "circle-ci-test"
  }
  spec {
    selector = {
      app = "circle-ci-test"
    }
    port {
      port = 8080
    }
  }
}

resource "kubernetes_ingress" "circle-ci" {
  metadata {
    name = "circle-ci"
  }
  spec {
    backend {
      service_name = "circle-ci-test"
      service_port = 8080
    }
  }
}
