-module(p08).
-export([compress/1]).
-import('p05', [reverse/1]).


compress([]) ->
    [];

compress([X1|Xs]) ->
    start_compress([X1|Xs], X1, []).


start_compress([], X, Acc) ->
    reverse([X|Acc]);

start_compress([X1|Xs], X1, Acc) ->
    start_compress(Xs, X1, Acc);

start_compress([X1|Xs], X, Acc) ->
    start_compress(Xs, X1, [X|Acc]).

