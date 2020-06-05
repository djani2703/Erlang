-module(p09).
-export([pack/1]).


pack([]) ->
    [];

pack([X|Xs]) ->
    start_pack([X|Xs], X, []).


start_pack([], _, Acc) ->
    [Acc];

start_pack([X|Xs], X, Acc) ->
    start_pack(Xs, X, [X|Acc]);

start_pack([X|Xs], _Xd, Acc) ->
    [Acc | start_pack(Xs,X,[X])].
