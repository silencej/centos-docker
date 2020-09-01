
FROM centos:7

RUN yum install -y epel-release https://repo.ius.io/ius-release-el7.rpm https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm ; \
  yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
RUN yum install -y ansible git224 yum-utils device-mapper-persistent-data lvm2 docker-ce docker-ce-cli containerd.io sudo ; \
  curl -L https://get.daocloud.io/docker/compose/releases/download/1.26.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose ; \
  chmod +x /usr/local/bin/docker-compose
