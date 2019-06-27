-module(p05).
-export([reverse/1]).

reverse(L) ->
    rev_acc(L, []).


rev_acc([], Acc) ->
    Acc;

rev_acc([X|Xs], Acc) ->
    rev_acc(Xs, [X|Acc]).
