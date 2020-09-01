
FROM centos:7

RUN yum install -y https://repo.ius.io/ius-release-el7.rpm https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm ; \
  yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
RUN yum install -y ansible git224 yum-utils device-mapper-persistent-data lvm2 docker-ce docker-ce-cli containerd.io sudo ; \
  export compose_version=$(curl -N -s https://github.com/docker/compose/tags | grep -E "/docker/compose/releases/tag/([\.0-9]*)\"" -m 1 -o |  cut -d/ -f 6 | cut -d\" -f 1) ; \
  curl -L https://get.daocloud.io/docker/compose/releases/download/${compose_version}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose ; \
  chmod +x /usr/local/bin/docker-compose
RUN useradd -G wheel,docker devops ; echo test | passwd --stdin devops

