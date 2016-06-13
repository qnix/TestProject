// Comment to get more information during initialization
// logLevel := Level.Warn

resolvers += Resolver.mavenLocal

resolvers += "Typesafe repository" at "https://repo.typesafe.com/typesafe/releases/"

resolvers += "simplytyped.com" at "https://raw.githubusercontent.com/simplytyped/simplytyped.github.io/master/repo/releases/"

addSbtPlugin("com.simplytyped" % "sbt-antlr4" % "0.7.4")
addSbtPlugin("com.typesafe.sbt" % "sbt-git" % "0.8.5")
addSbtPlugin("com.github.gseitz" % "sbt-release" % "1.0.3")
