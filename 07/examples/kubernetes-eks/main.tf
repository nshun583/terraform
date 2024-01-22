provider "aws" {
  region = "us-east-2"
}

module "eks-cluster" {
  source = "../../modules/services/eks-cluster"

  name         = "example-eks-cluster"
  min_size     = 1
  max_size     = 2
  desired_size = 1

  # EKSがENIを使用する方法の制約により、ワーカノードに使用できる最小の
  # インスタンスはt3.small。ENIを4つしか持たないt2.microなど
  # より小さいインスタンスタイプを使うと、システムサービス(kube-proxyなど)
  # しか起動できず、自分のPodをデプロイできない
  instance_types = ["t3.small"]
}

provider "kubernetes" {
  host = module.eks-cluster.cluster_endpoint
  cluster_ca_certificate = base64decode(
    module.eks-cluster.cluster_certificate_authority[0].data
  )
  token = data.aws_eks_cluster_auth.cluster.token
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks-cluster.cluster_name
}

module "simple_webapp" {
    source = "../../modules/services/k8s-app"

    name = "simple-webapp"
    image = "training/webapp"
    replicas = 2
    container_port = 5000

    environment_variables = {
        PROVIDER = "Readers"
    }
}

output "service_endpoint" {
    value = module.simple_webapp.service_endpoint
    description = "The K8S service endpoint"
  
}