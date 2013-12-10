#!/bin/bash
set -e
base_dir=$(dirname $0)

project_name=shavenmaven-sbtplugin
artifacts_dir=${base_dir}/target/scala-2.10/sbt-0.13
release_props=${artifacts_dir}/release.properties
build_number=${BUILD_NUMBER-dev.build}
release_name=${project_name}-${build_number}
release_jar=${release_name}.jar

${base_dir}/sbt.sh clean package

hg log -l 1 > ${artifacts_dir}/hg.properties
hg_summary=`grep summary ${artifacts_dir}/hg.properties | cut -d: -f2 | xargs`

echo "project.name=${project_name}" > ${release_props}
echo "release.files=${release_jar}" >> ${release_props}
echo "${release_name}.pom.labels=POM" >> ${release_props}
echo "release.version=${build_number}" >> ${release_props}
echo "release.path=com/googlecode/${project_name}/${project_name}/${build_number}" >> ${release_props}
echo "release.name=${release_name}" >> ${release_props}
echo "${release_jar}.description=${hg_summary} build:${build_number}" >> ${release_props}
echo "${release_jar}.labels=Jar" >> ${release_props}
echo "${release_jar}.pom.description=Maven POM file build:${build_number}" >> ${release_props}

artifact_uri=mvn:com.googlecode.${project_name}:${project_name}:jar:${build_number}
java -cp ${base_dir}/shavenmaven-94.jar com.googlecode.shavenmaven.PomGenerator ${artifact_uri} ${artifacts_dir}