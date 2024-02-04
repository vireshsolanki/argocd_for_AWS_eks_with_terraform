resource "aws_vpc" "eks-vpc" {
    cidr_block = var.vpc-cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    instance_tenancy = "default"
    tags = {
      Name = "${var.name}-vpc"
    }
}


resource "aws_internet_gateway" "eks-igw" {
    vpc_id = aws_vpc.eks-vpc.id
    tags = {
      Name = "${var.name}-igw"
    }
}

data "aws_availability_zones" "available" {
}

resource "aws_subnet" "pub-1-1a" {
    vpc_id = aws_vpc.eks-vpc.id
    availability_zone = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = true
    cidr_block = var.pub-1-1a
    tags = {
      Name = "${var.name}-pub-1-1a"
    }
}

resource "aws_subnet" "pub-2-1b" {
    vpc_id = aws_vpc.eks-vpc.id
    availability_zone = data.aws_availability_zones.available.names[1]
    map_public_ip_on_launch = true
    cidr_block = var.pub-2-1b
    tags = {
      Name = "${var.name}-pub-2-1b"
    }
}

resource "aws_subnet" "pri-1-1a" {
    vpc_id = aws_vpc.eks-vpc.id
    cidr_block = var.pri-1-1a
    availability_zone = data.aws_availability_zones.available.names[0]
    map_public_ip_on_launch = false
    tags = {
      Name = "${var.name}-pri-1-1a"
    }
}


resource "aws_subnet" "pri-2-1b" {
    vpc_id = aws_vpc.eks-vpc.id
    cidr_block = var.pri-2-1b
    availability_zone = data.aws_availability_zones.available.names[1]
    map_public_ip_on_launch = false
    tags = {
      Name = "${var.name}-pri-2-1b"
    }
}


resource "aws_route_table" "pub-rt" {
    vpc_id = aws_vpc.eks-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.eks-igw.id
    }
    tags = {
      Name = "${var.name}-pub-rt"
    }
}

resource "aws_route_table_association" "pub-1-1a-assoc" {
    subnet_id = aws_subnet.pub-1-1a.id
    route_table_id = aws_route_table.pub-rt.id
}

resource "aws_route_table_association" "pub-2-1b-assoc" {
    subnet_id = aws_subnet.pub-2-1b.id
    route_table_id = aws_route_table.pub-rt.id
}

