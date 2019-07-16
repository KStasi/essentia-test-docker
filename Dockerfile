FROM ubuntu:18.04

ARG git_repository="https://github.com/konchunas/Divi"
ARG path_to_build="/Divi/divi"
ARG with_encrypted_wallet=1

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y build-essential libtool autotools-dev autoconf pkg-config libssl-dev libboost-all-dev wget unzip libevent-dev openssl git
RUN wget http://download.oracle.com/berkeley-db/db-4.8.30.zip
RUN unzip db-4.8.30.zip
RUN pwd
WORKDIR /db-4.8.30/build_unix
RUN ../dist/configure --prefix=/usr/local --enable-cxx
RUN make && make install
WORKDIR /home/root
RUN rm -rf /db-4.8.30
COPY compile_git.sh compile_git.sh
RUN chmod +x ./compile_git.sh
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN ./compile_git.sh
RUN git clone $git_repository
WORKDIR /home/root$path_to_build
RUN ./autogen.sh
RUN ./configure --disable-tests --without-gui --with-unsupported-ssl
RUN make
COPY divi.conf /root/.divi/divi.conf
COPY boot.sh boot.sh
RUN chmod +x ./boot.sh
EXPOSE 51475
ENV WITH_ENCRYPTED_WALLET=$with_encrypted_wallet
ENTRYPOINT ./boot.sh