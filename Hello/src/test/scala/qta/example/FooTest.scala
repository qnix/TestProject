package qta.example

import org.scalatest._
import org.scalatest.Matchers
import scala.collection.mutable.Stack

abstract class UnitFlatSpec extends FlatSpec
  with Matchers with OptionValues with Inside with Inspectors

abstract class UnitFreeSpec extends FreeSpec
  with Matchers with OptionValues with Inside with Inspectors

class FooFlatTest extends UnitFlatSpec {
  "A Stack" should "pop values in last-in-first-out order" in {
    val stack = new Stack[Int]
    stack.push(1)
    stack.push(2)
    assert(stack.pop() === 2)
    assert(stack.pop() === 1)
  }
  it should "throw NoSuchElementException if an empty stack is popped" in {
    val emptyStack = new Stack[String]
    intercept[NoSuchElementException] {
      emptyStack.pop()
    }
  }
  it should "also be able to do other arbitrary things" in {
    val a = 5
    val b = 2
    assertResult(3)(a - b)
  }
}

class FooTest extends UnitFreeSpec {
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

