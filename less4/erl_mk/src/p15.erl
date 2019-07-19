-module(p15).
-export([replicate/2]).
-import('p05', [reverse/1]).


replicate(L, N) ->
    repl_elm(L, N, N, []).


repl_elm([], _, _, Acc) ->
    reverse(Acc);

repl_elm([_|Xs], N, 0, Acc) ->
    repl_elm(Xs, N, N, Acc);

repl_elm([X|_Xs], N, I, Acc) ->
    repl_elm([X|_Xs], N, I-1, [X|Acc]).
