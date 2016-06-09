package qta.example

case class Foo(value: String) {
  println(s"Foo with value: ${value}")
}

case class Bar() {
  println("this is Bar")
}

object Hello {
  def main(args: Array[String]) {
    println(">>>> Hello")

    val f = Foo("Test Foo")
    val b = Bar()

    val c = Bar
    val x = c()
  }
}
