#!/bin/sh
if [ $# -le 1 ]; then
    echo "usage: $0 container_to_debug with_image [-it]"
    exit 1
fi

# find container / to mount it
GRAPHDRIVER=$(docker inspect -f "{{.GraphDriver.Name}}" $1)
if [ $GRAPHDRIVER == "overlay2" ]; then
    CONTAINERFS=$(docker inspect -f "{{.GraphDriver.Data.MergedDir}}" $1)
else
    echo "graph driver not supported: $GRAPHDRIVER"
    exit 1
fi

# check other params
if [[ $# -ge 3 && $3 != "-it" ]]; then
    echo "third parameter must -it"
    exit 1
fi

if [[ $# -ge 3 && $3 == "-it" ]]; then
    BASH="/bin/bash"
else
    BASH=
fi

docker run --rm --privileged $3 -v $CONTAINERFS:/fs-debug --ipc=container:$1 --network=container:$1 --pid=container:$1 $2 $BASH
