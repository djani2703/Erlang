-module(p10).
-export([encode/1]).


encode([]) ->
    [{}];

encode([X|Xs]) ->
    start_encode([X|Xs], X, 0).


start_encode([], X, Cnt) ->
    [{Cnt, X}];

start_encode([X|Xs], X, Cnt) ->
    start_encode(Xs, X, Cnt+1);

start_encode([X|Xs], Y, Cnt) ->
    [{Cnt, Y} | start_encode(Xs, X, 1)].
