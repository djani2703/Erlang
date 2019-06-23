-module(p14).
-export([duplicate/1]).


duplicate([]) ->
    [];

duplicate([X|Xs]) ->
    [X, X | duplicate(Xs)].
