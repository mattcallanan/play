//package obj

object Main {
    var staticField: String = "abc";

  def main(args: Array[String]) {
    println("main: args = " + args)
    objectAsType(this)
  }

  def objectAsType(m: Main.type) = {
    m.utilMethod()
  }

  def utilMethod() = { println("I am utilMethod. staticField = " + staticField)}
}

class Main {
  var normalField = 123

  def memberMethod() = { println("I am memberMethod. normalField = "+normalField)}
}