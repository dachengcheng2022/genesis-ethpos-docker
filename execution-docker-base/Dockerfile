FROM golang:1.20

ARG VERSION
ARG SYMBOL
ARG SOURCE_CODE

ENV APP_ENV=local
ENV PYTHON_PIP_VERSION 21.1.3
ENV VERSION=${VERSION}
ENV SYMBOL=${SYMBOL}
ENV TZ=Asia/Shanghai \
    DEBIAN_FRONTEND=noninteractive

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

# 修改时区
RUN ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && rm -rf /var/lib/apt/lists/*

#instal geth env
RUN git clone --branch ${VERSION} ${SOURCE_CODE} \
    && cd go-ethereum \
    && make all \
    && mv /go/go-ethereum/build/bin/* /usr/local/bin/

RUN mkdir -p "/home/${SYMBOL}" \
  && chown -R "${SYMBOL}:${SYMBOL}" "/home/${SYMBOL}" \
  && mkdir  /data-ephemeral \
  && chown -R ${SYMBOL}:${SYMBOL} /data-ephemeral 

RUN echo 'Asia/Shanghai' > /etc/timezone