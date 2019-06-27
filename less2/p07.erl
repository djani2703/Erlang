-module(p07).
-export([flatten/1]).
-import(p05, [reverse/1]).


flatten([]) ->
    [];

flatten([X|Xs]) ->
    reverse(flatten_start([X|Xs], [])).


flatten_start([], Acc) ->
    Acc;

flatten_start([X=[_|_]|Xs], Acc) ->
    flatten_start(Xs, flatten_start(X, Acc));

flatten_start([_=[]|Xs], Acc) ->
    flatten_start(Xs, Acc);

flatten_start([X|Xs], Acc) ->
    flatten_start(Xs, [X|Acc]).
