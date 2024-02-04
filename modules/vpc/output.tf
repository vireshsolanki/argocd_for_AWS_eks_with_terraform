output "vpc-id" {
    value = aws_vpc.eks-vpc.id
}
output "igw-id" {
    value = aws_internet_gateway.eks-igw.id
}
output "pub-1-1a-id" {
    value = aws_subnet.pub-1-1a.id
}
output "pub-2-1b-id" {
    value = aws_subnet.pub-2-1b.id
}
output "pri-1-1a-id" {
    value = aws_subnet.pri-1-1a.id
}
output "pri-2-1b-id" {
    value = aws_subnet.pri-2-1b.id
}