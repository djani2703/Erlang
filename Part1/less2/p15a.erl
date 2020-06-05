-module(p15a).
-export([replicate/2]).

replicate([], _) ->
    [];

replicate([X|Xs], N) ->
    repl_elms(X, N, []) ++ replicate(Xs, N).


repl_elms(_, 0, Acc) ->
    Acc;

repl_elms(X, N, Acc) ->
    repl_elms(X, N-1, [X|Acc]).

