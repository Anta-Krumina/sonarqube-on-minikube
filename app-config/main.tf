provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

# Install PostgreSQL using the Bitnami Helm chart
resource "helm_release" "postgresql" {
  name       = "postgresql"
  repository = "oci://registry-1.docker.io/bitnamicharts"
  chart      = "postgresql"

  values = [
    file("${path.module}/postgresql-values.yaml")
  ]
}

# Create ConfigMap to pass jdbc username and url to Sonarqube
resource "kubernetes_config_map" "external_sonarqube_opts" {
  metadata {
    name      = "external-sonarqube-opts"
    namespace = "default"
  }

  data = {
    SONARQUBE_JDBC_USERNAME = "postgres"
    SONARQUBE_JDBC_URL      = "jdbc:postgresql://postgresql.default.svc.cluster.local:5432/sonarqube"
  }

  depends_on = [helm_release.postgresql]
}

# Install SonarQube using the Oteemo Helm chart
resource "helm_release" "sonarqube" {
  name       = "sonarqube"
  repository = "https://oteemo.github.io/charts"
  chart      = "sonarqube"

  values = [
    file("${path.module}/sonarqube-values.yaml")
  ]

  depends_on = [
    helm_release.postgresql, 
    kubernetes_config_map.external_sonarqube_opts
  ]
}
