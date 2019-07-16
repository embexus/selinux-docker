# Docker for Selinux 
Docker Image with debian stretch and all dependencies to work with selinux

## Generate Docker Image

        sudo docker build --rm=true --tag selinux-docker .
        
## Run Docker Image

       sudo docker run --rm --privileged -ti -h selinux \
             -v /path/to/refpolicy:/home/build/refpolicy selinux-docker

