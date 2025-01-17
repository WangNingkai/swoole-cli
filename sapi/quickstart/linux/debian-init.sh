#!/bin/bash

set -exu
__DIR__=$(
  cd "$(dirname "$0")"
  pwd
)

MIRROR=''
while [ $# -gt 0 ]; do
  case "$1" in
  --mirror)
    MIRROR="$2"
    ;;
  --*)
    echo "Illegal option $1"
    ;;
  esac
  shift $(($# > 0 ? 1 : 0))
done

case "$MIRROR" in
china | ustc | tuna)
  OS_ID=$(cat /etc/os-release | grep '^ID=' | awk -F '=' '{print $2}')
  VERSION_ID=$(cat /etc/os-release | grep '^VERSION_ID=' | awk -F '=' '{print $2}' | sed "s/\"//g")
  case $OS_ID in
  debian)
    case $VERSION_ID in
    11)
      test -f /etc/apt/sources.list.save || cp /etc/apt/sources.list /etc/apt/sources.list.save
      sed -i "s@deb.debian.org@mirrors.ustc.edu.cn@g" /etc/apt/sources.list
      sed -i "s@security.debian.org@mirrors.ustc.edu.cn@g" /etc/apt/sources.list
      test "$MIRROR" = "tuna" && sed -i "s@mirrors.ustc.edu.cn@mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
      ;;
    12)
      test -f /etc/apt//etc/apt/sources.list.d/debian.sources.save || cp /etc/apt/sources.list.d/debian.sources /etc/apt/sources.list.d/debian.sources.save
      sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list.d/debian.sources
      test "$MIRROR" = "tuna" && sed -i "s@mirrors.ustc.edu.cn@mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list.d/debian.sources
      ;;
    *)
      echo 'no match debian os version' . $VERSION_ID
      ;;
    esac
    ;;
  ubuntu)
    case $VERSION_ID in
    20.04 | 22.04 | 22.10 | 23.04 | 23.10)
      test -f /etc/apt/sources.list.save || cp /etc/apt/sources.list /etc/apt/sources.list.save
      sed -i "s@security.ubuntu.com@mirrors.ustc.edu.cn@g" /etc/apt/sources.list
      sed -i "s@archive.ubuntu.com@mirrors.ustc.edu.cn@g" /etc/apt/sources.list
      test "$MIRROR" = "tuna" && sed -i "s@mirrors.ustc.edu.cn@mirrors.tuna.tsinghua.edu.cn@g" /etc/apt/sources.list
      ;;
    *)
      echo 'no match ubuntu os version' . $VERSION_ID
      ;;
    esac
    ;;
  *)
    echo 'NO SUPPORT LINUX OS'
    exit 0
    ;;
  esac

  ;;

esac

test -f /etc/apt/apt.conf.d/proxy.conf && rm -rf /etc/apt/apt.conf.d/proxy.conf


apt update -y
apt install -y git curl wget ca-certificates
apt install -y xz-utils autoconf automake clang-tools clang lld libtool cmake bison re2c gettext coreutils lzip zip unzip
apt install -y pkg-config bzip2 flex p7zip

apt install -y gcc g++ musl-tools libtool-bin autopoint


# apt install build-essential linux-headers-$(uname -r)
apt install -y python3 python3-pip ninja-build  diffutils
apt install -y yasm nasm
apt install -y meson
apt install -y netcat-openbsd

case "$MIRROR" in
china | tuna)
  pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
  ;;
ustc)
  pip3 config set global.index-url https://mirrors.ustc.edu.cn/pypi/web/simple
  ;;

esac



