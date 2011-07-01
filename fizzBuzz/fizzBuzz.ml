-- What Is Functional Programming?
-- Craig Aspinall, 6-Jun-2011

let rec range i j = if i > j then [] else i :: (range (i+1) j) ;;


let fizz = function num -> num mod 3 == 0 ;;
let buzz num = num mod 5 == 0 ;;

let fbn num =
    if (fizz num) && (buzz num) then "FizzBuzz" else
        if (fizz num) then "Fizz" else
            if (buzz num) then "Buzz" else
                string_of_int num ;;

let fizzBuzz x = map fbn (range 1 x) ;;

let main = map print_endline (fizzBuzz 100) ;;


-- GUARDS

let fbnGuard num = match num with
      num when (fizz num && buzz num) -> "FizzBuzz"
    | num when fizz num -> "Fizz"
    | num when buzz num -> "Buzz"
    | _ -> string_of_int num ;;

let fizzBuzzGuard a = map fbnGuard (range 1 a) ;;

let mainGuard = map print_endline (fizzBuzzGuard 100) ;;


-- RECURSION

let rec fbnRecurse nums = match nums with
    [] -> []
  | (num::nums) -> fbnGuard num :: (fbnRecurse nums) ;;

let fizzBuzzRecurse a = fbnRecurse (range 1 a) ;;

let mainRecurse = map print_endline (fizzBuzzRecurse 100) ;;


(*
-- FOLD

let fizzBuzzFold a = List.fold_right fbnGuard (range 1 a) ;;
let mainFold = map print_endline (fizzBuzzFold 100) ;;
*)


-- LIST COMPREHENSION

fizzBuzzList upperBound = [fizzBuzzOrNumberGuard num | num <- [1..upperBound]]

mainList = forM_ (fizzBuzzList 100) putStrLn


-- DODGY

--fizzBuzzer :: (Num a, Monad m) => a -> m [Char]
--fizzBuzzer num = do  
--        if multipleOf3 num && multipleOf5 num then return "FizzBuzz" else
--            if multipleOf3 num then return "Fizz" else
--                if multipleOf5 num then return "Buzz" else
--                    return (show num)

--mainDodgy = do
--     colors <- forM [1..100] fizzBuzzOrNumber
--     mapM_ putStrLn colors

