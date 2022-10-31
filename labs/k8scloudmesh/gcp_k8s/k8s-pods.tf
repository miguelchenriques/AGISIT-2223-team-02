# Terraform google cloud multi tier Kubernetes deployment
# AGISIT Lab Cloud-Native Application in a Kubernetes Cluster

#################################################################
# Definition of the Pods
#################################################################

# The Backend Pods for Data Store deployment with REDIS
# Defines 1 Leader (not replicated)
# Defines 2 Followers (replicated) 
# see: https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/replication_controller

# Defines 1 REDIS Leader (not replicated)
resource "kubernetes_deployment" "redis-leader" {
  metadata {
    name = "redis-leader"
    labels = {
      app  = "redis"
      role = "leader"
      tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    progress_deadline_seconds = 1200 # In case of taking longer than 9 minutes
    replicas = 1
    selector {
      match_labels = {
        app  = "redis"
      }
    }
    template {
      metadata {
        labels = {
          app  = "redis"
          role = "leader"
          tier = "backend"
        }
      }
      spec {
        container {
          image = "docker.io/redis:6.0.5"
          name  = "leader"

          port {
            container_port = 6379
          }

          resources {
            requests = {
              cpu    = "100m"
              memory = "100Mi"
            }
          }
        }
      }
    }
  }
  depends_on = [
    helm_release.istiod,
    kubernetes_namespace.application
  ]
}
# Defines 2 REDIS Follower (replicated)
resource "kubernetes_deployment" "redis-follower" {
  metadata {
    name = "redis-follower"

    labels = {
      app  = "redis"
      role = "follower"
      tier = "backend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    progress_deadline_seconds = 1200 # In case of taking longer than 9 minutes
    replicas = 2
    selector {
      match_labels = {
        app  = "redis"
      }
    }
    template {
      metadata {
        labels = {
          app  = "redis"
          role = "follower"
          tier = "backend"
        }
      }
      spec {
        container {
          image = "gcr.io/google_samples/gb-redis-follower:v2"
          name  = "follower"

          port {
            container_port = 6379
          }

          env {
            name  = "GET_HOSTS_FROM"
            value = "dns"
          }

          resources {
            requests = {
              cpu    = "100m"
              memory = "100Mi"
            }
          }
        }
      }
    }
  }
  depends_on = [
    helm_release.istiod,
    kubernetes_namespace.application
  ]
}

#################################################################
# Defined the Frontend Pods for the GuestBook
# Only 3 replicas that will be Load balanced
resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "frontend"

    labels = {
      app  = "guestbook"
      tier = "frontend"
    }
    namespace = kubernetes_namespace.application.id
  }

  spec {
    replicas = 3
    selector {
      match_labels = {
        app  = "guestbook"
        tier = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app  = "guestbook"
          tier = "frontend"
        }
      }
      spec {
        container {
          image = "gcr.io/google-samples/gb-frontend:v5"
          name  = "php-redis"

          port {
            container_port = 80
          }

          env {
            name  = "GET_HOSTS_FROM"
            value = "dns"
          }

          resources {
            requests = {
              cpu    = "100m"
              memory = "100Mi"
            }
          }
        }
      }
    }
  }
  depends_on = [
    helm_release.istiod,
    kubernetes_namespace.application
  ]
}
