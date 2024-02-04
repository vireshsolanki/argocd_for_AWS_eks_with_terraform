output "eks-cluster-arn" {
    value = aws_iam_role.eks-node-policy.arn  
}
output "eks-node-arn" {
    value = aws_iam_role.eks-node-policy.arn 
}

output "eks-cluster-attachment-id" {
    value = aws_iam_role_policy_attachment.cluster-AmazonEKSClusterPolicy.id
}
output "eks-node-ec2r-id" {
    value = aws_iam_role_policy_attachment.node-AmazonEC2ContainerRegistryReadOnly.id
}

output "eks-node-wrk-id" {
    value = aws_iam_role_policy_attachment.node-AmazonEKSWorkerNodePolicy.id
}

output "eks-node-cni-id" {
    value = aws_iam_role_policy_attachment.node-AmazonEKS_CNI_Policy.id
  
}