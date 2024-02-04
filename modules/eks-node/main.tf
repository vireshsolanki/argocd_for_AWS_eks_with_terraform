resource "aws_eks_node_group" "eks-node" {
    cluster_name = var.eks-cluster-name
    node_group_name = "${var.name}-node"
    node_role_arn = var.eks-node-arn
    subnet_ids = [ var.pri-1-1a-id, var.pri-2-1b-id ]
    scaling_config {
      desired_size = 2
    max_size     = 3
    min_size     = 2
    }
    depends_on = [var.eks-node-cni-id,var.eks-node-ec2r-id,var.eks-node-wrk-id
  ]
}