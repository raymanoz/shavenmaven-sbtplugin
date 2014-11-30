#!/bin/bash

function moan(){
  echo -e "$1" 1>&2
  exit 1
}

cd "$( dirname "$0" )"

version=${BUILD_NUMBER-dev.build}
sbt -Dversion=${version} clean update test publish

cd target

function prepare_for_publish() {
    mkdir s3
    cp com/raymanoz/shavenmaven-sbtplugin/shavenmaven-sbtplugin_2.10_0.13/${version}/*${version}.jar s3
    cp com/raymanoz/shavenmaven-sbtplugin/shavenmaven-sbtplugin_2.10_0.13/${version}/*${version}-sources.jar s3
    cp com/raymanoz/shavenmaven-sbtplugin/shavenmaven-sbtplugin_2.10_0.13/${version}/*${version}.pom s3
}

prepare_for_publish || moan 'Failed to prepare_for_publish'