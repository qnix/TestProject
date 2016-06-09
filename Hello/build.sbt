name := "Hello"

version := "0.0.1-SNAPSHOT"

scalaVersion := "2.11.8"

javacOptions ++= Seq("-source", "1.7", "-target", "1.7")

scalacOptions += "-target:jvm-1.7"

incOptions := incOptions.value.withNameHashing(true)

lazy val scalaz = "org.scalaz" %% "scalaz-core" % "7.2.3"

lazy val netlib = "com.github.fommil.netlib" % "all" % "1.1.2" pomOnly()

libraryDependencies ++= Seq(
  "junit" % "junit" % "4.12" % "test",
  "org.scalacheck" %% "scalacheck" % "1.13.0" % "test",
  "org.scalatest" %% "scalatest" % "2.2.6" % "test"
)

// http://mvnrepository.com/artifact/com.esotericsoftware.kryo/kryo
libraryDependencies += "com.esotericsoftware.kryo" % "kryo" % "2.24.0"

libraryDependencies ++= Seq(
  scalaz,
  // "paxata" %% "grammar" % "0.6.27",
  // "org.apache.spark" %% "spark-core" % "1.6.0",
  // "org.apache.spark" %% "spark-mllib" % "1.6.0",
  netlib
)
