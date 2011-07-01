import scala.util.continuations._

def pre(m:String): String = {
    println("Printed in pre(): " + m)
    return "preReturnValue"
}

def substuff(m:String, x:String): String = {
    println("Printed in substuff(): m = " + m + ", x = " + x)
    return "substuffReturnValue"
}

def sub(m:String, x:String, subCont: (String) => Unit) {
    val y:String = substuff(m,x)
    subCont(y)
}

def post(m:String, x:String, y:String): String = {
    println("Printed in post(): m = " + m + ", x = " + x + ", y = " + y)
    return "postReturnValue"
}


def main(m:String, mainCont:(String)=>Unit):Unit = {
    val x:String = pre(m)
    sub(m,x, { (y:String) => {
        val z:String = post(m,x,y) 
        mainCont(z)
    }})
}

def prog(m:String) {
    main(m, { (z:String) =>
        println("Defined in prog: " + z)
        System.exit(0)
    })
    println("Done prog().")
}

prog("aaa")
