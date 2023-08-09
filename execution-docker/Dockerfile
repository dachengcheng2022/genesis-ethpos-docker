FROM golang

ARG DATA_DIR
ARG VERSION

ENV APP_ENV local
ENV TYPE ${TYPE}
ENV PYTHON_PIP_VERSION 21.1.3
ENV VERSION=${VERSION}
ENV DATA_DIR ${DATA_DIR}
ENV SYMBOL=ETH

RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg \
    procps \
    python3 \
    python3-distutils \
    unzip \
    git \
    make \
    cmake \
    gcc \
    xz-utils \
    lbzip2 \
    tar \
    gzip \
    net-tools \
    supervisor \
    j2cli \
    iputils-ping \
    telnet \
  && export DEBIAN_FRONTEND=noninteractive \
  && rm -rf /var/lib/apt/lists/* \
  && useradd -Urs /usr/sbin/nologin "${SYMBOL}"

#instal geth env
RUN git clone --branch ${VERSION} https://github.com/ethereum/go-ethereum.git \
    && cd go-ethereum \
    && make all \
    && mv /go/go-ethereum/build/bin/* /usr/local/bin/

RUN mkdir -p "/home/${SYMBOL}" \
  && chown -R "${SYMBOL}:${SYMBOL}" "/home/${SYMBOL}" \
  && mkdir ${DATA_DIR} /data-ephemeral \
  && chown -R ${SYMBOL}:${SYMBOL} ${DATA_DIR} /data-ephemeral 

# copy static node info
COPY execution-docker/resources/genesis.json /etc/genesis.json
COPY execution-docker/resources/supervisord.conf /etc/supervisord.conf
COPY execution-docker/resources/chown.supervisor.conf.j2 /etc/supervisor/conf.d/chown.supervisor.conf.j2
COPY execution-docker/resources/daemon.supervisor.conf.j2 /etc/supervisor/conf.d/daemon.supervisor.conf.j2
COPY execution-docker/resources/start_eth.sh /usr/local/bin/start_eth.sh
COPY execution-docker/resources/jwtsecret /etc/jwtsecret
COPY execution-docker/resources/UTC--2022-08-19T17-38-31.257380510Z--123463a4b065722e99115d6c222f267d9cabb524 /etc/UTC--2022-08-19T17-38-31.257380510Z--123463a4b065722e99115d6c222f267d9cabb524
COPY execution-docker/resources/geth_password.txt /etc/geth_password.txt

# transform jinja template to configuration file
RUN j2 /etc/supervisor/conf.d/daemon.supervisor.conf.j2 > /etc/supervisor/conf.d/${SYMBOL}.supervisor.conf \
  && j2 /etc/supervisor/conf.d/chown.supervisor.conf.j2 > /etc/supervisor/conf.d/chown.supervisor.conf \
  && chmod +x /usr/local/bin/start_eth.sh \
  && rm -f /etc/supervisor/conf.d/*.j2 /*.j2

VOLUME ${DATA_DIR} /data-ephemeral

EXPOSE ${PORT_RPC:-8545}
EXPOSE 8551
EXPOSE 30303


CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]
