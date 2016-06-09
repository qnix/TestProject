package qta.example

case class Foo(value: String, count: Int = 0) {
  println(s"Foo with value: ${value}")
}

object Hello {
  def main(args: Array[String]) {
    println(">>>> Hello")

    val f = Foo("Test Foo")
  }
}
