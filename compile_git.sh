#!/usr/bin/env bash
export TZ
mkdir ~/git-openssl
cd ~/git-openssl
cp /etc/apt/sources.list /etc/apt/sources.list~
sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
apt-get update -y
apt-get -y build-dep git
apt-get source git
dpkg-source -x git_2.17.1-1ubuntu0.4.dsc
cd git-2.17.1
apt-get install -y -f noninteractive libcurl4-openssl-dev
dpkg-buildpackage -rfakeroot -b
dpkg -i ../git_2.17.1-1ubuntu0.4_amd64.deb

