# Docker for Selinux 
Docker Image with Debian Buster and all dependencies to work with Selinux

## Generate Docker Image

        sudo docker build --build-arg USER=${USER} --build-arg UID=${UID} --rm=true --tag selinux-docker .
        
## Run Docker Image

       sudo docker run --rm --privileged -ti -h selinux \
             -v ${HOME}:${HOME} selinux-docker

