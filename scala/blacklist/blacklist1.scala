import scala.io.Source._
import java.io._

def printToFile(f: java.io.File)(op: java.io.PrintWriter => Unit) {
  val p = new java.io.PrintWriter(f)
  try { op(p) } finally { p.close() }
}

val header = "GivenName,Surname,StreetAddress,City,State,PostCode,EmailAddress,TelephoneNumber,Birthday,Gender"

val customers: List[String] = fromFile("customers.csv").getLines.drop(1).toList
val blacklist: List[String] = fromFile("blacklist.csv").getLines.drop(1).toList

val c = customers(521).split(",")(5)
val b = blacklist(2)

var output: List[String] = List()
for (c <- customers) {
    val p: String = c.split(",")(5)
    var blacklisted = false
    for (b <- blacklist) {
        if (b == p) blacklisted = true
    }
    if (!blacklisted) output = c :: output
}

printToFile(new File("approved.csv"))(p => {
  p.println(header)
  output.foreach(p.println)
})
