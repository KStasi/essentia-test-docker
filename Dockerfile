FROM ubuntu:18.04

ARG git_repository="https://github.com/konchunas/Divi"
ARG path_to_build="/Divi/divi"

RUN apt-get update
RUN apt-get install -y build-essential libtool autotools-dev autoconf pkg-config libssl-dev libboost-all-dev wget unzip libevent-dev openssl git
WORKDIR /home/root
COPY compile_git.sh compile_git.sh
RUN chmod +x ./compile_git.sh
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN ./compile_git.sh
RUN git clone $git_repository
WORKDIR /home/root$path_to_build
RUN ./autogen.sh
RUN apt-get install -y libdb++-dev libdb-dev
RUN ./configure --disable-tests --without-gui --with-unsupported-ssl  --with-incompatible-bdb
RUN make
COPY divi.conf /root/.divi/divi.conf
COPY boot.sh boot.sh
RUN chmod +x ./boot.sh
EXPOSE 51475
ENTRYPOINT ./boot.sh