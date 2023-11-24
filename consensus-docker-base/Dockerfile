FROM golang:1.20
ARG VERSION
ARG SYMBOL
ARG SOURCE_CODE
ARG DATA_DIR

ENV APP_ENV=local
ENV VERSION=${VERSION}
ENV SYMBOL=${SYMBOL}
ENV TZ=Asia/Shanghai \
    DEBIAN_FRONTEND=noninteractive
ENV PEER_INFO=${PEER_INFO}
ENV DATA_DIR=${DATA_DIR}
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
    python3-pip \
  && export DEBIAN_FRONTEND=noninteractive \
  && rm -rf /var/lib/apt/lists/* \
  && useradd -Urs /usr/sbin/nologin "${SYMBOL}"

#instal consensus client
RUN git clone --branch ${VERSION} ${SOURCE_CODE} \
    && cd prysm \
    && go build -o=../beacon-chain ./cmd/beacon-chain \
    && go build -o=../validator ./cmd/validator \
    && go build -o=../prysmctl ./cmd/prysmctl \
    && mv /go/beacon-chain /usr/local/bin/ \
    && mv /go/prysmctl /usr/local/bin/ \
    && mv /go/validator /usr/local/bin/


RUN mkdir -p "/home/${SYMBOL}" \
  && chown -R "${SYMBOL}:${SYMBOL}" "/home/${SYMBOL}" \
  && mkdir ${DATA_DIR} /data-ephemeral /execution \
  && chown -R ${SYMBOL}:${SYMBOL} ${DATA_DIR} /data-ephemeral /execution


RUN echo 'Asia/Shanghai' > /etc/timezone

