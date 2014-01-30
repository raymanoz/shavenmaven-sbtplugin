package com.googlecode.shavenmaven

import sbt._
import Keys._
import java.io.File

trait ShavenMaven {

  val shavenMavenTask = update <<= (update, baseDirectory) map {
    (updateReport, baseDirectory) => {
      val projectDir = new File(baseDirectory, "project")
      val libDir = new File(baseDirectory, "lib")
      Dependencies.update(projectDir, libDir)
      updateReport
    }
  } tag(Tags.Update)

}