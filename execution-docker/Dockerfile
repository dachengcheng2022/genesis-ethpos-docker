FROM debian


ARG DATA_DIR
ARG VERSION

ENV APP_ENV local
ENV TYPE ${TYPE}
ENV PYTHON_PIP_VERSION 21.1.3
ENV VERSION=${VERSION}
ENV DATA_DIR ${DATA_DIR}
ENV GOROOT=/usr/lib/go
ENV PATH=$PATH:/usr/lib/go/bin
ENV GOPATH=/root/go
ENV PATH=$GOPATH/bin/:$PATH
ENV SYMBOL=ETH
# RUN sed -i 's|deb http://security.debian.org/debian-security stable/updates main|deb http://security.debian.org/debian-security bullseye-security main contrib non-free|' /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
    wget \
    curl \
    gnupg \
    jq \
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
  && export DEBIAN_FRONTEND=noninteractive \
  && rm -rf /var/lib/apt/lists/* \
  && useradd -Urs /usr/sbin/nologin "${SYMBOL}"

#instal go env
RUN wget https://go.dev/dl/go1.19.1.linux-amd64.tar.gz \
     && tar -zxvf go1.19.1.linux-amd64.tar.gz \
     && mv go /usr/lib/go

#instal geth env
RUN git clone --branch ${VERSION} https://github.com/ethereum/go-ethereum.git \
    && cd go-ethereum \
    && make all \
    && mv /go-ethereum/build/bin/* /usr/local/bin/

RUN mkdir -p "/home/${SYMBOL}" \
  && chown -R "${SYMBOL}:${SYMBOL}" "/home/${SYMBOL}" \
  && mkdir ${DATA_DIR} /data-ephemeral \
  && chown -R ${SYMBOL}:${SYMBOL} ${DATA_DIR} /data-ephemeral 
  # get python stuff
  # && curl --fail -L 'https://bootstrap.pypa.io/get-pip.py' | python3 - "pip==$PYTHON_PIP_VERSION" \
  # && pip install --no-cache-dir argparse j2cli requests supervisor \
  #
  # add motd to remind you which container you're in
  # && echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd'  >> /etc/bash.bashrc \
  # && echo "Polo Digital Assets, Ltd. - Type: ${TYPE}, Symbol: ${SYMBOL}, Version: ${VERSION}" > /etc/motd


# copy static node info
COPY execution-docker/resources/genesis.json /etc/genesis.json
COPY execution-docker/resources/supervisord.conf /etc/supervisord.conf
COPY execution-docker/resources/chown.supervisor.conf.j2 /etc/supervisor/conf.d/chown.supervisor.conf.j2
COPY execution-docker/resources/daemon.supervisor.conf.j2 /etc/supervisor/conf.d/daemon.supervisor.conf.j2
COPY execution-docker/resources/start_eth.sh /usr/local/bin/start_eth.sh
COPY execution-docker/resources/jwtsecret /etc/jwtsecret

# transform jinja template to configuration file
RUN j2 /etc/supervisor/conf.d/daemon.supervisor.conf.j2 > /etc/supervisor/conf.d/${SYMBOL}.supervisor.conf \
  && j2 /etc/supervisor/conf.d/chown.supervisor.conf.j2 > /etc/supervisor/conf.d/chown.supervisor.conf \
  && chmod +x /usr/local/bin/start_eth.sh \
  && rm -f /etc/supervisor/conf.d/*.j2 /*.j2

VOLUME ${DATA_DIR} /data-ephemeral

EXPOSE ${PORT_RPC:-8545}

CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]
