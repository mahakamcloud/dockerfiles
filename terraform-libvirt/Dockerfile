FROM centos:7

RUN yum install -y \
    genisoimage-1.1.11 \
    libvirt \
    unzip \
    git \
    sshpass

RUN curl -O https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip \
    && unzip ./terraform_* \
    && mv ./terraform /usr/local/bin/terraform

RUN curl -LO https://github.com/dmacvicar/terraform-provider-libvirt/releases/download/v0.5.1/terraform-provider-libvirt-0.5.1.CentOS_7.x86_64.tar.gz \
    && tar -zxvf ./terraform-provider-* \
    && mkdir -p /root/.terraform.d/plugins \
    && mv ./terraform-provider-libvirt /root/.terraform.d/plugins/ \
    && rm -f ./terraform*

