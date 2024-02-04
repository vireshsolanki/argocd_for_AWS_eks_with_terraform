resource "aws_eks_cluster" "eks-cluster" {
    name = "${var.name}-cluster"
    role_arn = var.eks-cluster-arn
    version = "1.27"
    vpc_config {
        endpoint_private_access = false
        endpoint_public_access = true
      subnet_ids = [var.pri-1-1a-id,var.pri-2-1b-id]
    }
     depends_on = [
      var.eks-cluster-attachment-id
  ]
}
