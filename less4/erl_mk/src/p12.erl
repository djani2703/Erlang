-module(p12).
-export([decode_modified/1]).


decode_modified([]) ->
    [];

decode_modified([{Cnt, Elm}|Xs]) ->
    start_decode([{Cnt, Elm}|Xs], 1);

decode_modified([Elm|Xs]) ->
    start_decode([Elm|Xs], 1).


start_decode([], _) ->
    [];

start_decode([{Cnt, Elm}|Xs], Cnt)  ->
    [Elm|start_decode(Xs, 1)];

start_decode([{Cnt, Elm}|Xs], I) ->
    [Elm|start_decode([{Cnt, Elm}|Xs], I+1)];

start_decode([Elm|Xs], 1) ->
    [Elm|start_decode(Xs, 1)].
