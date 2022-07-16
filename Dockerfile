FROM --platform=linux/amd64 ubuntu:20.04

ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y \
    git \
    curl \
    libreadline-dev \
    pkg-config \
    autoconf \
    automake \
    build-essential \
    libmysqlclient-dev \
    libssl-dev \
    python3 \
    python3-dev \
    python3-venv \
    openjdk-8-jdk-headless \
    libxml2-dev \
    libcurl4-openssl-dev \
    libxslt1-dev \
    re2c \
    bison \
    libbz2-dev \
    libreadline-dev \
    libssl-dev \
    gettext \
    libgettextpo-dev \
    libicu-dev \
    libmhash-dev \
    libmcrypt-dev \
    libgd-dev \
    libtidy-dev \
    nginx \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m isucon

COPY . /home/isucon/webapp

RUN chown isucon:isucon -R /home/isucon/webapp \
    && chmod +x /home/isucon/webapp/debug.sh /home/isucon/webapp/killdlv.sh

USER isucon

RUN cd /home/isucon \
    && git clone https://github.com/tagomoris/xbuild.git \
    && mkdir local \
    && xbuild/go-install -f 1.18.1 ~/local/go

ENV PATH /home/isucon/local/go/bin:/home/isucon/go/bin:$PATH

RUN go install github.com/go-delve/delve/cmd/dlv@latest

USER root

WORKDIR /home/isucon/webapp