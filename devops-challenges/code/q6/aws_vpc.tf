resource aws_vpc tf-vpc{
    cidr_block = "10.0.0.0/16"
}

resource aws_subnet tf-vpc-subnet{
    vpc_id = aws_vpc.tf-vpc.id
    cidr_block = "10.0.1.0/24"
}

resource aws_internet_gateway tf-vpc-ig{
    vpc_id = aws_vpc.tf-vpc-id
}