-module(p01).
-export([last/1]).
-include_lib("eunit/include/eunit.hrl").


last([X|[]]) ->
    X;

last([_|Xs]) ->
    last(Xs).

    
    
% EUnit testing for the current function
last_test() ->
    ?assertEqual(last([12, 34, 'a', 78, 32]), 32),
    ?assertEqual(last("test"), 116),
    ?assertEqual(last([a, b, c, f, q, z]), z),
    ?assertEqual(last([a, 13, <<"Bin">>,'q',"new"]), "new"),
    ?assertException(error, function_clause, last(<<>>)),
    ?assertException(error, function_clause, last({})), 
    ?assertException(error, function_clause, last([])),
    ?assertException(error, function_clause, last(atom)),
    ?assertException(error, function_clause, last(5)).
