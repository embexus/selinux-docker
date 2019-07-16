FROM i386/debian:stretch

MAINTAINER Ayoub Zaki <ayoub.zaki@embexus.com> 

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y software-properties-common curl

# Required Packages for the Host Development System
RUN apt-get update && \
	apt-get install -y bc bsdmainutils gawk wget git-core diffstat unzip texinfo xz-utils debianutils iputils-ping libsdl1.2-dev && \
	apt-get install -y xutils-dev xterm build-essential chrpath socat fakeroot debhelper m4 python devscripts lintian

# Add OpenSSH
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd


# Add Selinux Packages
RUN apt-get install -y python3-sepolgen selinux-basics selinux-utils policycoreutils policycoreutils-dev policycoreutils-python-utils
RUN mkdir -p /var/run/sshd

# Add Vim
RUN apt-get install -y vim

# Create a non-root user that will perform the actual build
RUN id build 2>/dev/null || useradd --uid 1000 --create-home build
RUN apt-get install -y sudo
RUN echo "build ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

# make /bin/sh symlink to bash instead of dash
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

USER selinux
RUN echo "selinux:selinux" | sudo chpasswd
RUN echo -e "\n\n\n" | ssh-keygen -t rsa

RUN sudo chown -R selinux:selinux /home/selinux

WORKDIR /home/selinux
CMD ["/bin/bash"]

EXPOSE 22

# EOF
