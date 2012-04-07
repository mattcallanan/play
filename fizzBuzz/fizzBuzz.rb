
def multipleOf3(num)
   return num % 3 == 0
end

def multipleOf5(num)
   return num % 5 == 0
end

def fizzBuzzOrNumber(num)
  if (multipleOf3 num) && (multipleOf5 num)
    "FizzBuzz"
  elsif multipleOf3 num 
    "Fizz"
  elsif multipleOf5 num 
    "Buzz"
  else
    num
  end
end

def fizzBuzz(max)
  (1..max).map {|it|fizzBuzzOrNumber it}
end

def main()
  fizzBuzz(100).each {|it|puts it}
end

main
