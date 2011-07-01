package org.mcallana.learnscala.mixins

// http://www.scala-lang.org/node/117

object StringIteratorTest {
  def main(args: Array[String]) {
    class Iter extends StringIterator(args(0)) with RichIterator
    val iter = new Iter
    iter foreach println
  }
}
