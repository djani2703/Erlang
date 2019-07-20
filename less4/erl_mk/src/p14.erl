-module(p14).
-export([duplicate/1]).
-include_lib("eunit/include/eunit.hrl").


duplicate([]) ->
    [];

duplicate([X|Xs]) ->
    [X, X|duplicate(Xs)].


duplicate_test_() -> [
    ?_assertEqual(duplicate([<<>>, atom, 5, {a, b}, [elm]]), [<<>>,<<>>,atom,atom,5,5,{a,b},{a,b},[elm],[elm]]),
    ?_assertEqual(duplicate([]), []),
    ?_assertException(error, function_clause, duplicate(<<"bin">>)),
    ?_assertException(error, function_clause, duplicate({})), 
    ?_assertException(error, function_clause, duplicate(atom)),
    ?_assertException(error, function_clause, duplicate(12))
    ].
