module "vpc" {
    source = "../modules/vpc"
    region = var.region
    name = var.name
    vpc-cidr = var.vpc-cidr
    pub-1-1a = var.pub-1-1a
    pub-2-1b = var.pub-2-1b
    pri-1-1a = var.pri-1-1a
    pri-2-1b = var.pri-2-1b
    }


    module "natgateway" {
        source = "../modules/natgateway"
        name = var.name
        vpc-id = module.vpc.vpc-id
        igw-id = module.vpc.igw-id
        pri-1-1a-id = module.vpc.pri-1-1a-id
        pri-2-1b-id = module.vpc.pri-2-1b-id
        pub-1-1a-id = module.vpc.pub-1-1a-id
        pub-2-1b-id = module.vpc.pub-2-1b-id
        }
        
    module "iam" {
        source = "../modules/iam"
        name = var.name
    }
    
    module "eks-cluster" {
        source = "../modules/eks-cluster"
        name = var.name
        eks-cluster-arn = module.iam.eks-cluster-arn
        pri-1-1a-id = module.vpc.pri-1-1a-id
        pri-2-1b-id = module.vpc.pri-2-1b-id
        eks-cluster-attachment-id = module.iam.eks-cluster-attachment-id
    }
    module "eks-node" {
        source = "../modules/eks-node"
        name = var.name
        eks-cluster-name = module.eks-cluster.eks-cluster-name
        eks-node-arn = module.iam.eks-node-arn
        pri-1-1a-id = module.vpc.pri-1-1a-id
        pri-2-1b-id = module.vpc.pri-2-1b-id
        eks-node-cni-id = module.iam.eks-node-cni-id
        eks-node-ec2r-id = module.iam.eks-node-ec2r-id
        eks-node-wrk-id = module.iam.eks-node-wrk-id
    }
    module "argo-cd" {
        source = "../modules/argo-cd"
    }
    