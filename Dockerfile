FROM ubuntu:18.04

WORKDIR /home/server_admin
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y build-essential libtool autotools-dev autoconf pkg-config libssl-dev libboost-all-dev wget unzip libevent-dev
RUN wget http://download.oracle.com/berkeley-db/db-4.8.30.zip
RUN unzip db-4.8.30.zip
WORKDIR /home/server_admin/db-4.8.30/build_unix
RUN ../dist/configure --prefix=/usr/local --enable-cxx
RUN make && make install
WORKDIR /home/server_admin
COPY divi essentia
WORKDIR /home/server_admin/essentia
RUN ./autogen.sh
RUN ./configure --disable-tests --without-gui --with-unsupported-ssl
RUN make
COPY divi.conf /root/.divi/divi.conf
COPY boot.sh boot.sh
RUN chmod +x ./boot.sh
EXPOSE 51475
ENTRYPOINT ./boot.sh