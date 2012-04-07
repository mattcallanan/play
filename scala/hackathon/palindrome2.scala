def palindrome(n: Int) = n.toString == n.toString.reverse

def nums() = 1 to 999

def palindromes() = for (x <- nums; y <- nums; product = x * y; if palindrome(product)) yield (x, y, product)

def max(t1: (Int, Int, Int), t2: (Int, Int, Int)) = if ((t1._3) > (t2._3)) t1 else t2

def main() = {
    val p = palindromes().foldLeft((0,0,0))(max)
    println("largest: " + p._1 + " & " + p._2 + " (" + p._3 + ")")
}
