
#!/bin/sh
docker stop pbs && docker container rm pbs

# Build the developer image
docker build -t pbs:latest .

docker run \
    -p 9000:8000 \
    -it \
    --rm \
    -v ~/.aws/:/root/.aws \
    -v ./requirements.txt:/project/requirements.txt \
    -v ./matplotlib-demo.qmd:/project/matplotlib-demo.qmd \
    -v ./qp.sh:/project/qp.sh \
    --name pbs \
    pbs:latest \
    bash
