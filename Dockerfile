FROM python:3.12.5-bookworm@sha256:db5117bdc617075dcfebb40b2e5e6887750f83c385ebcaf1302412a6f3b1b147

COPY requirements.txt /project/requirements.txt

ARG QUARTO_VERSION="1.5.56"
ENV QUARTO_INSTALL_LOCATION="/usr/local/bin/quarto/${QUARTO_VERSION}"

# ca-certificates is required otherwise Quarto download will exit with code 77
RUN apt-get update && apt-get -y install --no-install-recommends curl ca-certificates

RUN curl -o quarto.tar.gz -L \
    "https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-arm64.tar.gz"

RUN mkdir -p ${QUARTO_INSTALL_LOCATION}

RUN tar -zxvf quarto.tar.gz \
    -C ${QUARTO_INSTALL_LOCATION} \
    --strip-components=1

RUN rm quarto.tar.gz

RUN ln -s "${QUARTO_INSTALL_LOCATION}/bin/quarto" /usr/bin/quarto

WORKDIR /project
RUN pip install -r requirements.txt