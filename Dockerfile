FROM debian:buster

MAINTAINER Ayoub Zaki <ayoub.zaki@embexus.com> 

# Install required Packages for the Host Development System
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y bc software-properties-common \
        bsdmainutils gawk wget git-core \
	diffstat unzip texinfo xz-utils debianutils  \
	xutils-dev xterm build-essential chrpath     \
        socat fakeroot debhelper m4 python devscripts \
        lintian libc6-dev vim auditd libxml2-utils

# Add Selinux Packages
RUN apt-get install -y selinux-policy-default python3-sepolgen \
	selinux-basics selinux-utils policycoreutils selinux-policy-dev \
        policycoreutils-dev policycoreutils-python-utils setools

ARG UID
ARG USER

# Create a non-root user USER
RUN id ${USER} 2>/dev/null || useradd --uid ${UID} --create-home ${USER}
RUN apt-get install -y sudo
RUN echo "${USER} ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers

# make /bin/sh symlink to bash instead of dash
RUN echo "dash dash/sh boolean false" | debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure dash

USER ${USER}
RUN echo "${USER}:${USER}" | sudo chpasswd

RUN sudo chown -R ${USER}:${USER} /home/${USER}

WORKDIR /home/${USER}
CMD ["/bin/bash"]

# EOF
