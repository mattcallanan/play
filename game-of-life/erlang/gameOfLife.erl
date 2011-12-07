%% HOWTO Run:
%% erl
%% > c(gameOfLife).
%% > gameOfLife:liveNeighbours({1,2},[{1,1},{2,2}]).
%% > [{X,Y} || {X,Y} <- [{1,1},{2,2}], lists:member({X,Y}, [{1,1},{2,2}])]

-module(gameOfLife).
-export([liveNeighbours/2, isAlive/2]).

%% Can't call own functions from guards.
%% isAlive({PointX, PointY}, World) when lists:member({PointX, PointY}, World) and lists:member(liveNeighbours({PointX, PointY}, World), [2,3]) -> true;
%% isAlive({PointX, PointY}, World) when (not lists:member({PointX, PointY}, World)) and liveNeighbours({PointX, PointY}, World) == 3 -> true;
%% isAlive(_, _) -> false.

liveNeighbours({PointX, PointY}, World) ->
%%    io:format("(~w, ~w), ~w~n", [X, Y, World]).
    length([{PointX+OffsetX,PointY+OffsetY} || {OffsetX, OffsetY} <- [{-1,-1},{0,-1},{1,-1},{-1,0},{1,0},{-1,1},{0,1},{1,1}], 	lists:member({PointX+OffsetX,PointY+OffsetY}, World)]).

isAlive({PointX, PointY}, World) ->
    CurrentlyAlive = lists:member({PointX, PointY}, World),
    if
        CurrentlyAlive -> 
            lists:member(liveNeighbours({PointX, PointY}, World), [2,3]);
        true ->   % works as an 'else' branch
            liveNeighbours({PointX, PointY}, World) == 3
    end.
  
%% fizz(X) -> (X rem 3 == 0).%% 
%% buzz(X) -> (X rem 5 == 0).%% 
%% fizzBuzz(X) -> fizz(X) and buzz(X).%% 
%% 
%% %% [X || X <- [1,2,3,5,10,12,15,30], fizzBuzz(X)].%% 
%% 
%% fbn(X) when (X rem 3 == 0) and (X rem 5 == 0) -> "FizzBuzz";%% 
%% fbn(X) when X rem 3 == 0 -> "Fizz";%% 
%% fbn(X) when X rem 5 == 0 -> "Buzz";%% 
%% fbn(X) -> integer_to_list(X).%% 
%% 
%% main() -> [io:format("~s~n", [fbn(X)]) || X <- lists:seq(1,100)].%% 
