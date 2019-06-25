-module(p07).
-export([flatten/1]).
-import(p05, [reverse/1]).

flatten([]) ->
    [];

flatten([X|Xs]) ->
    flatten_start([X|Xs], []).


flatten_start([], Acc) ->
    reverse(Acc);


%%need to change this function
flatten_start([X=[Xh|Xt]|Xs], Acc) ->
    flatten_start(Xt, [Xh|Acc]);


flatten_start([X=[]|Xs], Acc) ->
    flatten_start(Xs, Acc);

flatten_start([X|Xs], Acc) ->
    flatten_start(Xs, [X|Acc]).
