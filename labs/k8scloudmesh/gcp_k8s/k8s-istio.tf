# Terraform google cloud multi tier Kubernetes deployment
# AGISIT Lab Cloud-Native Application in a Kubernetes Cluster

# ISTIO Service Mesh deployment via Helm Charts
resource "helm_release" "istio_base" {
  name  = "istio-base"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart = "base"

  timeout = 120
  cleanup_on_fail = true
  force_update    = true
  namespace       = kubernetes_namespace.istio_system.metadata.0.name

  depends_on = [var.cluster, kubernetes_namespace.istio_system]
}

resource "helm_release" "istiod" {
  name  = "istiod"
  repository = "https://istio-release.storage.googleapis.com/charts"
  chart = "istiod"

  timeout = 120
  cleanup_on_fail = true
  force_update    = true
  namespace       = kubernetes_namespace.istio_system.metadata.0.name

  depends_on = [var.cluster, kubernetes_namespace.istio_system, helm_release.istio_base]
}
