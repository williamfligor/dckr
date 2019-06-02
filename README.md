# Building & Running

```bash
docker build \
    -t dckr \
    --build-arg UID=$UID \
    --build-arg GID=$GID \
    --build-arg BUILD_TIME="`date`" \
    .

docker run \
    -it \
    --rm\
    --network=host \
    -v `pwd`:/host \
    dckr
```
