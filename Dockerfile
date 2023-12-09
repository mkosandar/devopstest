FROM ubuntu:20.04
ENV VALHALLA_VERSION=3.0.7
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    cmake \
    git \
    libboost-all-dev \
    libcurl4-openssl-dev \
    libgeos++-dev \
    libluajit-5.1-dev \
    libprime-server-dev \
    libprotobuf-dev \
    libspatialite-dev \
    libsqlite3-dev \
    libsqlite3-mod-spatialite \
    libtool \
    locales \
    protobuf-compiler \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --branch ${VALHALLA_VERSION} --single-branch --depth 1 https://github.com/valhalla/valhalla.git /valhalla && \
    cd /valhalla && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j$(nproc) && \
    make install

# Expose Valhalla port
EXPOSE 8002

# Set the entry point
CMD ["valhalla_route_service", "8002"]
