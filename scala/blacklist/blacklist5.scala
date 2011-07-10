import scala.io.Source._
import java.io._

object Blacklist5 {
    def printToFile(f: java.io.File)(op: java.io.PrintWriter => Unit) {
        val p = new java.io.PrintWriter(f)
        try { op(p) } finally { p.close() }
    }

    case class Customer(line: String) {
        val data = line.split(",")
        val GivenName = data(0)
        val Surname = data(1)
        val StreetAddress = data(2)
        val City = data(3)
        val State = data(4)
        val PostCode = data(5)
        val EmailAddress = data(6)
        val TelephoneNumber = data(7)
        val Birthday = data(8)
        val Gender = data(9)
//        override def toString = GivenName + ", " + Surname + ", " + StreetAddress + ", " + City + ", " + State + ", " + PostCode + ", " + EmailAddress + ", " + TelephoneNumber + ", " + Birthday + ", " + Gender
        override def toString = this.productIterator.toList.mkString("", ",", "")
    }

    def main(args : Array[String]) : Unit = {
        val header = "GivenName,Surname,StreetAddress,City,State,PostCode,EmailAddress,TelephoneNumber,Birthday,Gender"

        val custs: Iterator[Customer] = fromFile(args(0)).getLines.drop(1).map (l => Customer(l))
        val blacklist: List[String] = fromFile(args(1)).getLines.drop(1).toList

        var output = custs.filter(c => !blacklist.contains(c.PostCode)) 

        printToFile(new File(args(2)))(p => {
            p.println(header)
            output.foreach(p.println)
        })
        println("Done.")
    }
}
