import com.raymanoz.shavenmaven.ShavenMaven.shavenMavenTask
import sbt.{Build, Defaults, Project, file}

object MyBuild extends Build {

  lazy val basicSettings = Defaults.defaultSettings

  lazy val root = Project(id = "test-project",
    base = file("."),
    settings = basicSettings ++ Seq(shavenMavenTask)
  )
}