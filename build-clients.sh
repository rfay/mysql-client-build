#!/bin/bash

set -eu -o pipefail
set -x

for mysql_version in 8.4.0 8.0.36 5.7.44; do
  for arch in linux/amd64 linux/arm64; do
    if [ ! -d mysql_${mysql_version} ]; then
      curl -L --fail -o /tmp/mysql.tgz https://dev.mysql.com/get/Downloads/MySQL-${mysql_version%.?}/mysql-${mysql_version}.tar.gz
      mkdir -p mysql_${mysql_version} && pushd mysql_${mysql_version}
      tar --strip-components=1 -zxf /tmp/mysql.tgz
    fi
    pushd mysql_${mysql_version}
    echo "Building ${arch} for mysql ${mysql_version}"
    docker run --rm --platform=${arch} -v .:/src randyfay/cmake
    popd
  done
done