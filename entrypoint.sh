#!/bin/bash
set -e

git submodule update --init
cd zephyr
export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
export ZEPHYR_SDK_INSTALL_DIR=${ZEPHYR_SDK_INSTALL_DIR:-/opt/toolchains/zephyr-sdk-0.10.3}
source zephyr-env.sh
cd ../application
mkdir -p build
cd build
cmake -DBOARD=m2gl025_miv ..
make -j$(nproc)
cp zephyr/zephyr.elf ../../artifacts
cd ../../
/opt/renode/tests/test.sh -r artifacts zephyr.robot
