package qta.example

case class Foo(value: String, count: Int = 0) {
  println(s"Foo with value: ${value}")
}

case class Bar() {
  println("this is Bar")
}

case class Baz(message: String) {
  println("This is Baz")
}

object Hello extends App {
  override def main(args: Array[String]) {
    println(">>>> Hello")

    val f = Foo("Test Foo")
    val b = Bar()

    val c = Bar
    val x = c()

    val z = Baz("Message is required")
  }
}
