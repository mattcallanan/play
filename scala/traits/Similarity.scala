package org.mcallana.learnscala.traits

// http://www.scala-lang.org/node/126

trait Similarity {
  def isSimilar(x: Any): Boolean
  def isNotSimilar(x: Any): Boolean = !isSimilar(x)
}
