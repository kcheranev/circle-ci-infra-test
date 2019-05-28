resource "kubernetes_service_account" "circle-ci" {
  metadata {
    name = "circle-ci"
  }
}

resource "kubernetes_cluster_role_binding" "circle-ci" {
  metadata {
    name = "circle-ci"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind = "ClusterRole"
    name = "cluster-admin"
  }
  subject {
    kind = "User"
    name = "circle-ci"
  }
}
