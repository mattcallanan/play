package org.mcallana.learnscala.mixins

// http://www.scala-lang.org/node/117

trait RichIterator extends AbsIterator {
  def foreach(f: T => Unit) { while (hasNext) f(next) }
}
