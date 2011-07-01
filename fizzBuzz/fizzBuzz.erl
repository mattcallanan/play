-module(fizzBuzz).
-export([main/0]).

fizz(X) -> (X rem 3 == 0).
buzz(X) -> (X rem 5 == 0).
fizzBuzz(X) -> fizz(X) and buzz(X).

%% [X || X <- [1,2,3,5,10,12,15,30], fizzBuzz(X)].

fbn(X) when (X rem 3 == 0) and (X rem 5 == 0) -> "FizzBuzz";
fbn(X) when X rem 3 == 0 -> "Fizz";
fbn(X) when X rem 5 == 0 -> "Buzz";
fbn(X) -> integer_to_list(X).

main() -> [io:format("~s~n", [fbn(X)]) || X <- lists:seq(1,100)].
