// load with -P:continuations:enable

import scala.util.continuations._

def doSomething1 = reset {
    println("Ready?")
    val result = 1+special*3
    println(result)
}

def special = shift {
    k:(Int => Unit) => println(99); "Gotcha!"
}
