//package obj

object Main {
    var staticField: String = "abc";

  def main(args: Array[String]) {
    objectAsType(this)
  }

  def objectAsType(m: Main.type) = {
    m.utilMethod()
  }

  def utilMethod() = {}
}

class Main {
  var normalField = 123

  def memberMethod() = {}
}