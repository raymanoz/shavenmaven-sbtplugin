#!/bin/bash
set -e
base_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
build_number=${BUILD_NUMBER-dev.build}

cd ${base_dir}
sed "s/%BUILD_NUMBER%/${build_number}/g" build.sbt.template > build.sbt

exec java -Xmx512M ${SBT_OPTS} -jar sbt-launch.jar "$@"