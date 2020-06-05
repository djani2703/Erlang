-module(p01).
-export([last/1]).
-include_lib("eunit/include/eunit.hrl").


last([X|[]]) ->
    X;

last([_|Xs]) ->
    last(Xs).

    
last_test_() -> [
    ?_assertEqual(last([12, 34, 'a', 78, 32]), 32),
    ?_assertEqual(last("test"), 116),
    ?_assertEqual(last([a, b, c, f, q, z]), z),
    ?_assertEqual(last([a, 13, <<"Bin">>,'q',"new"]), "new"),
    ?_assertException(error, function_clause, last(<<>>)),
    ?_assertException(error, function_clause, last({})), 
    ?_assertException(error, function_clause, last([])),
    ?_assertException(error, function_clause, last(atom)),
    ?_assertException(error, function_clause, last(5))
    ].
