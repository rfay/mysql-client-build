#!/bin/bash

set -eu -o pipefail

set -x

cmake -Bbuild -H. -DWITHOUT_SERVER=1 -DDOWNLOAD_BOOST=1 -DWITH_BOOST=/usr/local/boost
cd build
make mysql mysqldump

# Binaries end up in build/runtime_output_directory
chmod +x runtime_output_directory/mysql runtime_output_directory/mysqldump

# Output version to verify
runtime_output_directory/mysql --version
runtime_output_directory/mysqldump --version
