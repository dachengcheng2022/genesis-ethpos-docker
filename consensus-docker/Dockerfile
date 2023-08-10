FROM golang:1.20


ARG DATA_DIR
ARG VERSION
ARG SYMBOL

ENV APP_ENV local
ENV TYPE ${TYPE}
ENV PYTHON_PIP_VERSION 21.1.3
ENV VERSION=${VERSION}
ENV DATA_DIR ${DATA_DIR}
ENV SYMBOL=${SYMBOL}
ENV TZ=Asia/Shanghai \
    DEBIAN_FRONTEND=noninteractive

# 修改时区
RUN ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && rm -rf /var/lib/apt/lists/*
    
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

#instal consensus client
RUN git clone --branch ${VERSION} https://github.com/prysmaticlabs/prysm.git \
    && cd prysm \
    && go build -o=../beacon-chain ./cmd/beacon-chain \
    && go build -o=../validator ./cmd/validator \
    && go build -o=../prysmctl ./cmd/prysmctl \
    && mv /go/beacon-chain /usr/local/bin/ \
    && mv /go/prysmctl /usr/local/bin/ \
    && mv /go/validator /usr/local/bin/


RUN mkdir -p "/home/${SYMBOL}" \
  && chown -R "${SYMBOL}:${SYMBOL}" "/home/${SYMBOL}" \
  && mkdir ${DATA_DIR} /data-ephemeral \
  && chown -R ${SYMBOL}:${SYMBOL} ${DATA_DIR} /data-ephemeral 


# copy static node info
COPY consensus-docker/resources/config.yml /etc/config.yml

COPY consensus-docker/resources/supervisord.conf /etc/supervisord.conf
COPY consensus-docker/resources/chown.supervisor.conf.j2 /etc/supervisor/conf.d/chown.supervisor.conf.j2
COPY consensus-docker/resources/daemon.supervisor.conf.j2 /etc/supervisor/conf.d/daemon.supervisor.conf.j2
COPY consensus-docker/resources/start_beacon.sh /usr/local/bin/start_beacon.sh
COPY consensus-docker/resources/start_validator.sh /usr/local/bin/start_validator.sh
COPY consensus-docker/resources/jwtsecret /etc/jwtsecret

# transform jinja template to configuration file
RUN j2 /etc/supervisor/conf.d/daemon.supervisor.conf.j2 > /etc/supervisor/conf.d/${SYMBOL}.supervisor.conf \
  && j2 /etc/supervisor/conf.d/chown.supervisor.conf.j2 > /etc/supervisor/conf.d/chown.supervisor.conf \
  && chmod +x /usr/local/bin/start_beacon.sh \
  && chmod +x /usr/local/bin/start_validator.sh \
  && rm -f /etc/supervisor/conf.d/*.j2 /*.j2

RUN echo 'Asia/Shanghai' > /etc/timezone

VOLUME ${DATA_DIR} /data-ephemeral

EXPOSE ${PORT_RPC:-8545}

CMD [ "/usr/bin/supervisord", "-c", "/etc/supervisord.conf" ]
