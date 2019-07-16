FROM i386/debian:stretch

MAINTAINER Ayoub Zaki <ayoub.zaki@embexus.com> 

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y software-properties-common

# Required Packages for the Host Development System
RUN apt-get update && \
	apt-get install -y bc bsdmainutils gawk wget git-core diffstat unzip texinfo xz-utils debianutils && \
	apt-get install -y xutils-dev xterm build-essential chrpath socat fakeroot debhelper m4 python devscripts lintian

# Add Selinux Packages
RUN apt-get install --no-install-recommends -y python3-sepolgen selinux-basics selinux-utils policycoreutils policycoreutils-dev policycoreutils-python-utils

# Create a non-root user selinux
RUN id selinux 2>/dev/null || useradd --uid 1000 --create-home selinux
RUN apt-get install -y sudo
RUN echo "selinux ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

# make /bin/sh symlink to bash instead of dash
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

USER selinux
RUN echo "selinux:selinux" | sudo chpasswd

RUN sudo chown -R selinux:selinux /home/selinux

WORKDIR /home/selinux
CMD ["/bin/bash"]

# EOF
