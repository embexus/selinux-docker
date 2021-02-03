# Docker for Selinux 
Docker Image with Ubuntu 18.04 and all dependencies to work with selinux

## Generate Docker Image

        sudo docker build --build-arg USER=${USER} --build-arg UID=${UID} --rm=true --tag selinux-docker .
        
## Run Docker Image

       sudo docker run --rm --privileged -ti -h selinux \
             -v ${HOME}:${HOME} selinux-docker

