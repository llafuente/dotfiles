# docker

Collection of commands

## Common commands

    docker start --name ${CONTAINER_NAME} ${IMAGE_NAME}
    docker stop ${CONTAINER_NAME}


    docker pull ubuntu:latest
    docker create --name ${CONTAINER_NAME} ubuntu:latest

## bash inside

    docker exec -it XXX bash


## swarm ~nodes info

TODO: this is no-swarm-mode only?

    docker -H tcp://lpnov523:35270 info

## Remove (container) by name

    docker rm -f $(docker ps --filter "name=zuul-nova3" --format "{{.ID}}")

## Run docker with root priviledges

    docker run -it --privileged --name XXX XXX

# Run docker that crash on start

    docker run --entrypoint=/bin/bash --name XXX XXX

## Run docker with modprobe on host network

    docker run --network=host --cap-add=ALL -v /lib/modules:/lib/modules --privileged -itd --name XXX XXX

## Remove container and image by name

When you

    CONTAINER_ID=$(docker ps --filter "ancestor=${IMAGE_NAME}" --format "{{.ID}}")

    CONTAINER_NAME="a"
    IMAGE_ID=$(docker ps --filter "name=${CONTAINER_NAME}" --format "{{.Image}}")
    CONTAINER_ID=$(docker ps --filter "name=${CONTAINER_NAME}" --format "{{.ID}}")
    docker rm -f "${CONTAINER_ID}"
    docker rmi -f "${IMAGE_ID}"

## Remove stopped

no resources available to schedule container

    docker stop $(docker ps -q)
    docker rm $(docker ps -a -q)

## hard remove

Sometimes even a stopped machine can be removed, or worst some changes are inside host

    docker rm -fv "${CONTAINER_ID}"

## copy file inside a docker

    docker cp ${FILE_PATH} poc_master:${FILE_PATH}

    # fast for binaries :)
    docker cp $(which killall) poc_master:$(which killall)


NOTE: attributes/ownership is copied.

To copy something with a user/group that doesn't exists in the host machine use:

    chmod user_id:group_id file

## Edit docker files when stopped

    # get the overlay path, maybe another *Dir
    docker inspect poc_master | grep LowerDir
    # goto
    cd xxxx
    # edit desired file
    find .


## Cleanup

    docker container prune   # Remove all stopped containers
    docker volume prune      # Remove all unused volumes
    docker image prune       # Remove unused images

    docker system prune      # All of the above, in this order: containers, volumes, images
    docker system df # Show docker disk usage, including space reclaimable by pruning

# Swarm

    --restart=on-failure:10 --memory-swappiness="0" -m 1250m --memory-swap="1250m" --cpus=1.0


# Troubleshooting

## Script start fail

try to run with an override ENTRYPOINT:

   docker run --entrypoint /bin/sh

Alertnative: modify the script adding `sleep 9999999` before the crash point,
then `docker cp`.


## Clear docker logs

    echo "" > $(docker inspect --format='{{.LogPath}}' ${CONTAINER_ID})


## Working with running instances

    CONTAINER_ID=
    CONTAINER_ID=$(docker ps -a --filter name=xxx -q)

    docker start ${CONTAINER_ID}; docker logs -f ${CONTAINER_ID}
    docker stop ${CONTAINER_ID}

    # stop first then copy, then start (sometimes it's needed <- silent fail)
    docker cp server.js ${CONTAINER_ID}:/micro-gateway/server.js
    docker cp config-server.js ${CONTAINER_ID}:/app/src/config-server.js
    docker cp /tmp/xxx ${CONTAINER_ID}:/xxx


    docker exec -it ${CONTAINER_ID} /bin/bash

    docker inspect ${CONTAINER_ID}
    docker logs -f ${CONTAINER_ID}
    docker rm -f ${CONTAINER_ID}

## Connect two containers

### Same compose

Add the same network in the compose.

### Different compose

After both are up, check networks with docker inspect, then

    docker network connect network-compose1 container-compose2


## wine

```
IMAGE=scottyhardy/docker-wine
docker pull scottyhardy/docker-wine
docker image rm scottyhardy/docker-wine

docker create --name wine scottyhardy/docker-wine


docker start wine -m=1g -a -i
docker ps -l
docker logs -f dda0f0b62765
docker stop wine
docker rm wine

docker exec -it wine /bin/bash

docker volume create winehome

cd xvfb-run -a wine Ahk2Exe.exe /in
xvfb-run -a wine Ahk2Exe.exe /in src/bot.ahk /out bin/bot.exe



docker run -it --rm --hostname="DESKTOP-LEVCF87" --shm-size=1g --volume="winehome:/home/wineuser" --workdir=/home/wineuser --env="USER_NAME=bls" --env="USER_UID=1000" --env="USER_GID=1000" --env="USER_HOME=/home/wineuser" --env="XVFB=yes" --env="XVFB_SERVER=:95" --env="XVFB_SCREEN=0" --env="XVFB_RESOLUTION=640x480x8"  scottyhardy/docker-wine /bin/bash



/usr/bin/Xvfb :96 -screen 0 640x480x8 &
export DISPLAY=:96
winetricks d3dcompiler_43 d3dx9_43 dotnet48

xvfb-run -a wine lib/@rda/autohotkey/Compiler/Ahk2Exe.exe "/in" "src/bot.ahk" "/bin" "lib/@rda/autohotkey/Compiler/Unicode 32-bit.bin" "/icon" "bin/icon_bbva_pps_icon.ico" "/out" "bin/bot2.exe"


xvfb-run -a wine Ahk2Exe.exe /in c:\\windows\\src\\bot.ahk /bin "c:\\windows\\Unicode 32-bit.bin" /icon c:\\windows\\bin\\icon_bbva_pps_icon.ico /out c:\\windows\\bot.exe


xvfb-run -a wine lib/@rda/autohotkey/Compiler/Ahk2Exe.exe /in "src/bot.ahk" /bin "lib/@rda/autohotkey/Compiler/Unicode 32-bit.bin" /icon "bin/icon_bbva_pps_icon.ico" /out "bin/bot.exe"




docker cp -a d:\bbva\bot 00144beb312c:/home/wineuser/rda
docker cp -a d:\bbva\bot e346b8f1822b:/home/node/.wine/drive_c/windows/rda

USER_HOME="/home/wineuser"
USER_VOLUME="winehome"
XVFB="no"
XVFB_RESOLUTION="640x480x8"
XVFB_SCREEN="0"
XVFB_SERVER=":95"

--hostname="$(hostname)" \
--volume="winehome:${USER_HOME}"tcp,rw"'
--workdir=${USER_HOME}
--env="USER_NAME=$(whoami)" \
--env="USER_UID=$(id -u)"
--env="USER_GID=$(id -g)"
--env="USER_HOME=${USER_HOME}"
--env="XVFB=yes"
--env="XVFB_SERVER=${XVFB_SERVER}"
--env="XVFB_SCREEN=${XVFB_SCREEN}"
--env="XVFB_RESOLUTION=${XVFB_RESOLUTION}"
--env="DISPLAY=${XVFB_SERVER}"



```

```
docker pull ubuntu:latest
```

Dockerfile
