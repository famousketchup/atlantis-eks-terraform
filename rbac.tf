resource "kubernetes_cluster_role_binding" "eks_admin" {
  metadata { name = "eks-admin-binding" }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "User"
    name      = "eks-admin"
    api_group = "rbac.authorization.k8s.io"
  }
}
