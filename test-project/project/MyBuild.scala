import sbt._
import Keys._

object MyBuild extends Build with ShavenMaven {

  lazy val basicSettings = Defaults.defaultSettings

  lazy val root = Project(id = "test-project",
    base = file("."),
    settings = basicSettings ++ Seq(shavenMavenTask)
  )
}