-module(p03).
-export([element_at/2]).


element_at([X|_], 1) ->
    X;

element_at([_|Xs], N) ->
    element_at(Xs, N-1);

element_at([], _) ->
    undefined.
