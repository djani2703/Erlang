-module(p13).
-export([decode/1]).


decode([]) ->
    [];

decode([{Cnt, Elm}|Xs]) ->
    start_decode([{Cnt, Elm}|Xs], 1).


start_decode([], _) ->
    [];

start_decode([{Cnt, Elm}|Xs], Cnt)  ->
    [Elm | start_decode(Xs, 1)];

start_decode([{Cnt, Elm}|Xs], I) ->
    [Elm | start_decode([{Cnt, Elm}|Xs], I+1)].
