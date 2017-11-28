# docker

Collection of commands

## Common commands

    docker start --name ${CONTAINER_NAME} ${IMAGE_NAME}
    docker stop ${CONTAINER_NAME}

## bash inside

    docker exec -it XXX bash


## Remove (container) by name

docker rm -f $(docker ps --filter "name=zuul-nova3" --format "{{.ID}}")

## Run docker with root priviledges

    docker run -it --privileged --name XXX XXX

## Run docker with modprobe on host network

    docker run --network=host --cap-add=ALL -v /lib/modules:/lib/modules --privileged -itd --name XXX XXX

## Remove container and image by name

When you

    CONTAINER_NAME="a"
    IMAGE_ID=$(docker ps --filter "name=${CONTAINER_NAME}" --format "{{.Image}}")
    CONTAINER_ID=$(docker ps --filter "name=${CONTAINER_NAME}" --format "{{.ID}}")
    docker rm -f "${CONTAINER_ID}"
    docker rmi -f "${IMAGE_ID}"

## hard remove

Sometimes even a stopped machine can be removed, or worst some changes are inside host

    docker rm -fv "${CONTAINER_ID}"

## copy file inside a docker

    docker cp ${FILE_PATH} poc_master:${FILE_PATH}

    # fast for binaries :)
    docker cp $(which killall) poc_master:$(which killall)


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

