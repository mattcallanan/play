//scalac -P:continuations:enable ${sourcefiles}
//scala -P:continuations:enable ${classname}

import scala.util.continuations._  
   
object A {
    def main(args: Array[String]) {
        println(doInt())
        println(doString())
        println(doMultiString())
    }
    
    def doInt():Int = {
            reset {
              shift { k: (Int=>Int) =>
                k(7)
              } + 1
            }
    }
    
    def doString():String = {
            reset {
              shift { k: (String=>String) =>
                k("xyz")
              }.concat("abc")
            }
    }
    
    def doMultiString():String = {
            reset {
              shift { k: (Int,String=>String) =>
                k(k("xyz"))
              }.concat("abc")
            }
    }

}