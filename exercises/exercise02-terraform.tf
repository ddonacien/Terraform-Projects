#Terraform configuration with the terraform block
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
#Set up your AWS provider with the provider block
provider "aws" {
  region = "us-east-2"
}
#Create a VPC using ths 'aws_vpc' resource to specify your CIDR block for your VPC as well as name
resource "aws_vpc" "demo_vpc" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = "Terraform VPC"
  }
}
#Create two subnets within this VPC using the aws_subnet resource
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.0.0.0/24"
}
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.demo_vpc.id
  cidr_block = "10.0.1.0/24"
}
#Create an internet gateway and attach your VPC with the aws_internet_gateway resource
resource "aws_internet_gateway" "igw" {
  vpc_id     = aws_vpc.demo_vpc.id
}
#Create a route table using the aws_route_table resource
resource "aws_route_table" "public_rtb" {
  vpc_id     = aws_vpc.demo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
#Associate the route table with the public subnet using the aws_route_table_association resource
resource "aws_route_table_association" "public_subnet" {
  subnet_id      = aws_subenet.public_subnet.id
  route_table_id = aws_route_tabl.public_rtb.id
}
