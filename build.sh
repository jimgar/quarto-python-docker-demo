#!/bin/sh
docker stop py-deb && docker container rm py-deb

docker build -t py-deb:latest .

docker run \
    -p 127.0.0.1:9000:8000 \
    -it \
    --rm \
    -v ~/.aws/:/root/.aws \
    -v ./:/project \
    --name py-deb \
    py-deb:latest \
    bash
