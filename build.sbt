sbtPlugin := true

scalaVersion := "2.10.4"

scalaBinaryVersion := "2.10"

name := "shavenmaven-sbtplugin"
 
organization := "com.raymanoz.shavenmaven-sbtplugin"

version := Option(System.getProperty("version")).getOrElse("dev.build")
 
resolvers += "Bodart Repo" at "http://repo.bodar.com/"
 
libraryDependencies += "com.googlecode.shavenmaven" % "shavenmaven" % "95" classifier "dep"
 
libraryDependencies += "org.hamcrest" % "hamcrest-core" % "1.2.1"
 
libraryDependencies += "org.hamcrest" % "hamcrest-library" % "1.2.1"
 
libraryDependencies += "junit" % "junit-dep" % "4.8.2"
 
libraryDependencies += "com.googlecode.totallylazy" % "totallylazy" % "1130"
 
libraryDependencies += "com.googlecode.utterlyidle" % "utterlyidle" % "707"

publishTo := Some(Resolver.file("file", new File("target")))