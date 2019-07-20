-module(p14).
-export([duplicate/1]).
-include_lib("eunit/include/eunit.hrl").


duplicate([]) ->
    [];

duplicate([X|Xs]) ->
    [X, X|duplicate(Xs)].


duplicate_test() ->
    ?assertEqual(duplicate([<<>>, atom, 5, {a, b}, [elm]]), [<<>>,<<>>,atom,atom,5,5,{a,b},{a,b},[elm],[elm]]),
    ?assertEqual(duplicate([]), []),
    ?assertException(error, function_clause, duplicate(<<"bin">>)),
    ?assertException(error, function_clause, duplicate({})), 
    ?assertException(error, function_clause, duplicate(atom)),
    ?assertException(error, function_clause, duplicate(12)).
