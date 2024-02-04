resource "aws_eip" "eks-eip-a" {
    vpc = true
    tags = {
      Name = "${var.name}-eip-a"
    }
}
resource "aws_eip" "eks-eip-b" {
    vpc = true
    tags = {
      Name = "${var.name}-eip-b"
    }
}


resource "aws_nat_gateway" "eks-natgw-a" {
    allocation_id = aws_eip.eks-eip-a.id
    subnet_id = var.pub-1-1a-id
    tags = {
      Name = "${var.name}-natgw-a"
    }
    depends_on = [ var.igw-id]
}


resource "aws_nat_gateway" "eks-natgw-b" {
    allocation_id = aws_eip.eks-eip-b.id
    subnet_id = var.pub-2-1b-id
    tags = {
      Name = "${var.name}-natgw-b"
    }
    depends_on = [ var.igw-id]
}


resource "aws_route_table" "pri-rt"  {
    vpc_id = var.vpc-id
    route  {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.eks-natgw-a.id
    }
    tags = {
      Name = "${var.name}-pri-rt"
    }
}


resource "aws_route_table_association" "pri-1-1a-assoc" {
    subnet_id = var.pri-1-1a-id
    route_table_id = aws_route_table.pri-rt.id
}

resource "aws_route_table_association" "pri-1-1b-assoc" {
    subnet_id = var.pri-2-1b-id
    route_table_id = aws_route_table.pri-rt.id
  
}
