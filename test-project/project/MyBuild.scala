import com.googlecode.shavenmaven.ShavenMaven
import sbt.{Build, Defaults, Project, file}

object MyBuild extends Build with ShavenMaven {

  lazy val basicSettings = Defaults.defaultSettings

  lazy val root = Project(id = "test-project",
    base = file("."),
    settings = basicSettings ++ Seq(shavenMavenTask)
  )
}