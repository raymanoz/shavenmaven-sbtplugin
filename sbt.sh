#!/bin/bash
set -e
BUILD_NUMBER=${BUILD_NUMBER-dev.build}
sed "s/%BUILD_NUMBER%/${BUILD_NUMBER}/g" build.sbt.template > build.sbt

exec java -Xmx512M ${SBT_OPTS} -jar sbt-launch.jar "$@"