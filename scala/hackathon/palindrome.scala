def palindrome(n: Int) = { n.toString() == n.toString().reverse }

def palindromePairs() = for (x <- (1 to 999); y <- (1 to 999) if palindrome(x * y)) yield (x, y)

def maxPair(p1: (Int, Int), p2: (Int, Int)) = { if ((p1._1 + p1._2) > (p2._1 + p2._2)) p1 else p2 }

def main() = {
    val p = palindromePairs().foldLeft((0,0))(maxPair)
    println("largest pair: " + p)
    println("palindrome: " + p._1 * p._2)
}
