package qta.example

import org.scalatest._
import org.scalatest.Matchers

abstract class UnitSpec extends FreeSpec with Matchers with OptionValues with Inside with Inspectors

class FooTest extends FreeSpec with Matchers {
  "Class Foo" - {
    "Should have some test" in {
      val foo = Foo("Hello", 1)
      foo.value shouldEqual("Hello")
      foo.count shouldEqual(1)
    }
  }
}

class FooFunSuiteTest extends FunSuite {
  test("An empty Set should have size 0") {
    assert(Set.empty.size == 0)
  }

  test("Invoking head on an empty Set should produce NoSuchElementException") {
    intercept[NoSuchElementException] {
      Set.empty.head
    }
  }
}

class FooFreeSpecTest extends FreeSpec {
  "A Set" - {
    "when empty" - {
      "should have size 0" in {
        assert(Set.empty.size == 0)
      }
      "should produce NoSuchElementException when head is invoked" in {
        intercept[NoSuchElementException] { Set.empty.head }
      }
    }
  }
}

class FooSpecTest extends Spec {
  object `A Set` {
    object `when empty` {
      def `should have size 0` {
        assert(Set.empty.size == 0)
      }
      def `should produce NoSuchElementException when head is invoked` {
        intercept[NoSuchElementException] {
          Set.empty.head
        }
      }
    }
  }
}

