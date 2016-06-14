package qta.example

import org.scalatest.FreeSpec
import org.scalatest.Matchers


class BarTest extends FreeSpec with Matchers {
  "Class Bar" - {
    "Should have some test" in {
      val bar = Bar()
      bar should not be (null)
    }
  }
}
