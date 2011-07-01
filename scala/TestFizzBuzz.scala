import org.scalacheck._
import org.scalacheck.Prop._
import FizzBuzz._


object TestFizzBuzz extends Properties("fbn") {
  property("fbn: == 5 is Buzz") = forAll { 
      (num: Int) => (num == 5) ==> (FizzBuzz.fbn(num) == "Buzz") 
  }
}

val propFbn = forAll { num: Int => 
  (num == 5) ==> 
    (FizzBuzz.fbn(num) == "Buzz")
}
propFbn.check


val propMakeList = forAll { n: Int =>
  (n >= 0 && n < 10000) ==> 
    (List.make(n, "").length == n)
}
propMakeList.check


/*
// What Is Functional Programming?
// Craig Aspinall, 6-Jun-2011

object FizzBuzz {

def multipleOf3(num: Int): Boolean = num % 3 == 0
def multipleOf5(num: Int): Boolean = num % 5 == 0


// JAVA-LIKE
def fbn(num: Int): String = {
    if (multipleOf3(num) && multipleOf5(num)) "fb" 
    else if (multipleOf3(num)) "Fizz" 
    else if (multipleOf5(num)) "Buzz" 
    else num.toString
}

def fb (a: Int): List[String] = 
    List.range(1, a+1).map(fbn)

def mainJava = fb(100).map(println)


// GROOVY-LIKE

def fbGroovy(a: Int):List[String] = {
    val values = 1 to a toList
    var result = List[String]()
    values.foreach { x =>
        result = result ::: List(fbnGuard(x))
    }
    result
}

def mainGroovy = fbGroovy(100).map(println)


// PATTERN-MATCHING (GUARDS)

def fbnGuard(num: Int): String = num match {
    case num if multipleOf3(num) && multipleOf5(num) => "fb" 
    case num if multipleOf3(num) => "Fizz" 
    case num if multipleOf5(num) => "Buzz" 
    case _ => num.toString
}

def fbGuard (a: Int): List[String] = 
    List.range(1, a+1).map(fbn)

def mainGuard = fbGuard(100).map(println)


// RECURSION

def fbnRecurse(list: List[Int]):List[String] = list match {
    case Nil => List()
    case num :: nums => fbn(num) :: fbnRecurse(nums)
}

def fbRecurse(a: Int): List[String] = fbnRecurse(1 to a toList)

def mainRecurse = fbRecurse(100).map(println)


// FOLD-LEFT, FOLD-RIGHT

def fbFoldLeft1(a: Int): List[String] = 
    List.range(1, a+1).foldLeft(List[String]())((result,current) => result ::: List(fbnGuard(current)))
def mainFoldLeft1 = fbFoldLeft1(100).map(println)

def fbFoldLeft2(a: Int): List[String] = 
    (List[String]() /: List.range(1, a+1))((result,current) => result ::: List(fbnGuard(current)))
def mainFoldLeft2 = fbFoldLeft2(100).map(println)

def fbFoldRight1(a: Int): List[String] = 
    List.range(1, a+1).foldRight(List[String]())((current,result) => fbnGuard(current) :: result)
def mainFoldRight1 = fbFoldRight1(100).map(println)

def fbFoldRight2(a: Int): List[String] = 
    (List.range(1, a+1) :\ List[String]())((current,result) => fbnGuard(current) :: result)
def mainFoldRight2 = fbFoldRight2(100).map(println)



// FOR COMPREHENSION

def fbList(a: Int): List[String] = for (num <- (1 to a toList)) yield fbnGuard(num)
def mainList = fbList(100).map(println)



def main(args : Array[String]) = println(fbn(20))
}
*/