
FROM centos:7

RUN yum install -y https://repo.ius.io/ius-release-el7.rpm https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm ; \
  yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
RUN yum install -y ansible git224 yum-utils device-mapper-persistent-data lvm2 docker-ce docker-ce-cli containerd.io sudo openssh-server; \
  export compose_version=$(curl -N -s https://github.com/docker/compose/tags | grep -E "/docker/compose/releases/tag/([\.0-9]*)\"" -m 1 -o |  cut -d/ -f 6 | cut -d\" -f 1) ; \
  curl -L https://get.daocloud.io/docker/compose/releases/download/${compose_version}/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose ; \
  chmod +x /usr/local/bin/docker-compose
RUN useradd -G wheel,docker devops ; echo test | passwd --stdin devops ; echo test | passwd --stdin root

# Dockerfile for systemd base image
# https://hub.docker.com/_/centos?tab=description
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]

RUN sed 's/^account    required     pam_nologin.so$/#account    required     pam_nologin.so/' /etc/pam.d/sshd
