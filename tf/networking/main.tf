### Networking Stuff

resource "aws_vpc" "k8s-hard-way-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    project = "k8s-hard-way",
    Name    = "k8s-hard-way-vpc"
  }
}

resource "aws_subnet" "k8s-hard-way-private-subnet" {
  vpc_id     = aws_vpc.k8s-hard-way-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    project = "k8s-hard-way",
    Name    = "k8s-hard-way-private-subnet"
  }
}
resource "aws_subnet" "k8s-hard-way-public-subnet" {
  vpc_id     = aws_vpc.k8s-hard-way-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    project = "k8s-hard-way",
    Name    = "k8s-hard-way-public-subnet"
  }
}

resource "aws_internet_gateway" "k8s-hard-way-igw" {
  vpc_id     = aws_vpc.k8s-hard-way-vpc.id
  depends_on = [aws_vpc.k8s-hard-way-vpc]

  tags = {
    project = "k8s-hard-way"
    Name    = "k8s-hard-way-igw"
  }
}

resource "aws_route_table" "k8s-hard-way-public-rt" {
  vpc_id     = aws_vpc.k8s-hard-way-vpc.id
  depends_on = [aws_internet_gateway.k8s-hard-way-igw]
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.k8s-hard-way-igw.id
  }
  tags = {
    project = "k8s-hard-way"
    Name    = "k8s-hard-way-public-rt"
  }
}

resource "aws_route_table_association" "k8s-hard-way-public-rt-association" {
  subnet_id      = aws_subnet.k8s-hard-way-public-subnet.id
  route_table_id = aws_route_table.k8s-hard-way-public-rt.id
  depends_on     = [aws_route_table.k8s-hard-way-public-rt]
}

#### security groups

resource "aws_security_group" "k8s-hard-way-ssh-access" {
  name        = "k8s-hard-way-ssh-access"
  description = "Security group for SSH access to jumpbox"
  vpc_id = aws_vpc.k8s-hard-way-vpc.id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: This allows SSH from ANY IP. Restrict it!
  }

  tags = {
    project = "k8s-hard-way"
    Name = "ssh-access-sg"
  }
}

resource "aws_security_group" "k8s-hard-way-internet-egress" {
  name        = "k8s-hard-way-internet-egress"
  description = "Security group for internet egress"
  vpc_id = aws_vpc.k8s-hard-way-vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    project = "k8s-hard-way"
    Name    = "k8s-hard-way-internet-egress"
  }
}

