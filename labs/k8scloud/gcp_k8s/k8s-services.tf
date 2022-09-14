# Terraform google cloud multi tier Kubernetes deployment
# AGISIT Lab Cloud-Native Application in a Kubernetes Cluster

#################################################################
# Definition of the Services
#################################################################

# The Service for the REDIS Leader Pods
resource "kubernetes_service" "redis-leader" {
  metadata {
    name = "redis-leader"

    labels = {
      app  = "redis"
      role = "leader"
      tier = "backend"
    }
  }

  spec {
    selector = {
      app  = "redis"
      role = "leader"
      tier = "backend"
    }

    port {
      port        = 6379
      target_port = 6379
    }
  }
}
# The Service for the REDIS Follower Pods
resource "kubernetes_service" "redis-follower" {
  metadata {
    name = "redis-follower"

    labels = {
      app  = "redis"
      role = "follower"
      tier = "backend"
    }
  }

  spec {
    selector = {
      app  = "redis"
      role = "follower"
      tier = "backend"
    }

    port {
      port        = 6379
    }
  }
}

#################################################################
# The Service for the Frontend Load Balancer Ingress
resource "kubernetes_service" "frontend" {
  metadata {
    name = "frontend"

    labels = {
      app  = "guestbook"
      tier = "frontend"
    }
  }

  spec {
    selector = {
      app  = "guestbook"
      tier = "frontend"
    }

    type = "LoadBalancer"

    port {
      port = 80
    }
  }
}