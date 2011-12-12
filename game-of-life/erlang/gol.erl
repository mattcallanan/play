%% HOWTO Run:
%% erl
%% > c(gol).
%% > gol:progress(gol:acorn()).
%% > [{X,Y} || {X,Y} <- [{1,1},{2,2}], lists:member({X,Y}, [{1,1},{2,2}])]

-module(gol).
-export([liveNeighbours/2, willLive/2, progress/1, acorn/0, minX/1]).

%%toString(World) -> [io:format("~s~n", [fbn(X)]) || Y <- lists:seq(minY(World), maxY(World)), X <- lists:seq(minX(World), maxX(World))]

progress(World) -> [{X,Y} || X <- lists:seq(minX(World), maxX(World)), Y <- lists:seq(minY(World), maxY(World)), willLive({X,Y},(World))].

minX(World) -> lists:min(element(1, lists:unzip(World))).
maxX(World) -> lists:max(element(1, lists:unzip(World))).
minY(World) -> lists:min(element(2, lists:unzip(World))).
maxY(World) -> lists:max(element(2, lists:unzip(World))).

willLive({X, Y}, World) ->
    CurrentlyAlive = lists:member({X, Y}, World),
    if
        CurrentlyAlive -> 
            lists:member(liveNeighbours({X, Y}, World), [2,3]);
        true ->   % works as an 'else' branch
            liveNeighbours({X, Y}, World) == 3
    end.

%% Can't call own functions from guards.
%% willLive({PointX, PointY}, World) when lists:member({PointX, PointY}, World) and lists:member(liveNeighbours({PointX, PointY}, World), [2,3]) -> true;
%% willLive({PointX, PointY}, World) when (not lists:member({PointX, PointY}, World)) and liveNeighbours({PointX, PointY}, World) == 3 -> true;
%% willLive(_, _) -> false.

liveNeighbours({PointX, PointY}, World) ->
%%    io:format("(~w, ~w), ~w~n", [X, Y, World]).
    length([{PointX+OffsetX,PointY+OffsetY} || {OffsetX, OffsetY} <- [{-1,-1},{0,-1},{1,-1},{-1,0},{1,0},{-1,1},{0,1},{1,1}], 	lists:member({PointX+OffsetX,PointY+OffsetY}, World)]).


    
acorn() -> [{2,1},{4,2},{1,3},{2,3},{5,3},{6,3},{7,3}].


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
