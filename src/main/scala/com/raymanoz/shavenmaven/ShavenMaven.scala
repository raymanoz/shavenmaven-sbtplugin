package com.raymanoz.shavenmaven

import com.googlecode.shavenmaven.Dependencies
import sbt.Tags.Update
import sbt.Keys.{update, baseDirectory}
import java.io.File

object ShavenMaven extends sbt.Plugin {

  val shavenMavenTask = update <<= (update, baseDirectory) map {
    (updateReport, baseDirectory) => {
      val projectDir = new File(baseDirectory, "project")
      val libDir = new File(baseDirectory, "lib")
      Dependencies.update(projectDir, libDir)
      updateReport
    }
  } tag Update

}