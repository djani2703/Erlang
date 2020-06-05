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

    
flatten_test_() -> [
    ?_assertEqual(flatten("hello"), "hello"),
    ?_assertEqual(flatten([atom, [8, [123, 'b']], 145, 'w']), [atom, 8, 123, 'b', 145, 'w']),
    ?_assertEqual(flatten([a, [134, 'b', ['c' ,[18, 55]], 35], 90]), [a, 134, b, c, 18, 55, 35, 90]),
    ?_assertException(error, function_clause, flatten(<<"bin">>)),
    ?_assertException(error, function_clause, flatten({})), 
    ?_assertException(error, function_clause, flatten(atom)),
    ?_assertException(error, function_clause, flatten(125))
    ].
