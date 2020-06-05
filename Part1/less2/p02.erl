-module(p02).
-export([but_last/1]).


but_last([_,_] = List) ->
    List;

but_last([_|Xs]) ->
    but_last(Xs).
