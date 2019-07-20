-module(p07).
-export([flatten/1]).
-import(p05, [reverse/1]).
-include_lib("eunit/include/eunit.hrl").


flatten([]) ->
    [];

flatten([X|Xs]) ->
    reverse(flatten([X|Xs], [])).


flatten([], Acc) ->
    Acc;

flatten([X=[_|_]|Xs], Acc) ->
    flatten(Xs, flatten(X, Acc));

flatten([_=[]|Xs], Acc) ->
    flatten(Xs, Acc);

flatten([X|Xs], Acc) ->
    flatten(Xs, [X|Acc]).

    
flatten_test() ->
    ?assertEqual(flatten("hello"), "hello"),
    ?assertEqual(flatten([atom, [8, [123, 'b']], 145, 'w']), [atom, 8, 123, 'b', 145, 'w']),
    ?assertEqual(flatten([a, [134, 'b', ['c' ,[18, 55]], 35], 90]), [a, 134, b, c, 18, 55, 35, 90]),
    ?assertException(error, function_clause, flatten(<<"bin">>)),
    ?assertException(error, function_clause, flatten({})), 
    ?assertException(error, function_clause, flatten(atom)),
    ?assertException(error, function_clause, flatten(125)).
