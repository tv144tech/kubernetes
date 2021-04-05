#
### Kubernetes cluster (minkube) installation script ###
#
## Installation script works on Amazon Linux 2 (use t2.medium or larger EC2 instances)
#
## @author: tv144tech, april 2021
#
#!/bin/bash
#
# Install kubectl from repo (workaround: gpg disabled because of failures -> non-prod use!)
sudo bash -c 'cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=0
repo_gpgcheck=0
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF'
#
sudo yum install -y kubectl
#
# Avoid yum/rpm conflicts while starting different installation jobs
#
sleep 5
#
# Download and install minikube
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm
sudo rpm -ivh minikube-latest.x86_64.rpm
#
# Avoid yum/rpm conflicts while starting different installation jobs
#
sleep 5
#
# Install Docker as minikube driver 
#
sudo yum install -y docker
#
# Avoid yum/rpm conflicts while starting different installation jobs
#
sleep 5
#
minikube config set driver docker
#
sudo usermod -a -G docker ec2-user
sudo service docker start
#
echo
echo Start Kubernetes cluster \(minkube\) with command \(on a new console!\): \$ minikube start
echo 
#
### End of Kubernetes cluster (minkube) installation script ###
#
