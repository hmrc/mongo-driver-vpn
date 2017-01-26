


resolvers += "Typesafe repository releases" at "http://repo.typesafe.com/typesafe/releases/"

val dependencies = Seq(
  //"org.reactivemongo" %% "reactivemongo" % "0.12.1",
  "org.slf4j" % "slf4j-api" % "1.7.5",
  "org.slf4j" % "slf4j-simple" % "1.7.5"
)


lazy val reactiveMongoSrc =
  //ProjectRef(uri("https://github.com/opetch/ReactiveMongo.git#master"), "ReactiveMongo")
  ProjectRef(uri("https://github.com/opetch/ReactiveMongo.git#zombies"), "ReactiveMongo")


lazy val root = (project in file("."))
  .settings(
    name         := "SbtStructTemplate2",
    organization := "org.hmrc",
    scalaVersion := "2.11.8",
    version      := "1.0",
    libraryDependencies ++= dependencies
  )
  .dependsOn(reactiveMongoSrc)
