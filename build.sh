BUILD_NUMBER=${BUILD_NUMBER-dev.build}
sed "s/%BUILD_NUMBER%/${BUILD_NUMBER}/g" build.sbt.template > build.sbt
sbt $*