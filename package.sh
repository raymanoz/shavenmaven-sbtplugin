#!/bin/bash
set -e
base_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

scala_version=2.10
sbt_version=0.13
project_name=shavenmaven-sbtplugin
artifacts_dir=${base_dir}/target/scala-${scala_version}/sbt-${sbt_version}
release_props=${artifacts_dir}/release.properties
build_number=${BUILD_NUMBER-dev.build}
release_name=${project_name}-${build_number}
release_jar=${release_name}.jar
release_pom=${release_name}.pom
pom_file=${artifacts_dir}/${release_pom}

chmod +x ${base_dir}/sbt.sh
${base_dir}/sbt.sh clean package

cd ${base_dir}
hg log -l 1 > ${artifacts_dir}/hg.properties
hg_summary=`grep summary ${artifacts_dir}/hg.properties | cut -d: -f2 | xargs`

echo "project.name=${project_name}" > ${release_props}
echo "release.files=${release_jar},${release_pom}" >> ${release_props}
echo "${release_name}.pom.labels=POM" >> ${release_props}
echo "release.version=${build_number}" >> ${release_props}
echo "release.path=com/googlecode/${project_name}/${project_name}_${scala_version}_${sbt_version}/${build_number}/" >> ${release_props}
echo "release.name=${release_name}" >> ${release_props}
echo "${release_jar}.description=${hg_summary} build:${build_number}" >> ${release_props}
echo "${release_jar}.labels=Jar" >> ${release_props}
echo "${release_jar}.pom.description=Maven POM file build:${build_number}" >> ${release_props}

artifact_uri=mvn:com.googlecode.${project_name}:${project_name}:jar:${build_number}
java -cp ${base_dir}/shavenmaven-94.jar com.googlecode.shavenmaven.PomGenerator ${artifact_uri} ${artifacts_dir}

awk '/<dependencies>/{print "<properties>";print "<sbtVersion>0.13</sbtVersion>";print "<scalaVersion>2.10<s/scalaVersion>";print "</properties>";print"";}1' ${pom_file} > ${pom_file}-temp
rm ${pom_file}
mv ${pom_file}-temp ${pom_file}
