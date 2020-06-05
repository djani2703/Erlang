-module(p10).
-export([encode/1]).
-include_lib("eunit/include/eunit.hrl").


encode([]) ->
    [];

encode([X|Xs]) ->
    encode([X|Xs], X, 0).


encode([], X, Cnt) ->
    [{Cnt, X}];

encode([X|Xs], X, Cnt) ->
    encode(Xs, X, Cnt+1);

encode([X|Xs], Y, Cnt) ->
    [{Cnt, Y} | encode(Xs, X, 1)].
    

encode_test_() -> [
    ?_assertEqual(encode([a, a, a, b, c, c, d, d, d, e]), [{3, a}, {1, b}, {2, c}, {3, d}, {1, e}]),
    ?_assertEqual(encode("hello"), [{1, 104}, {1, 101}, {2, 108}, {1, 111}]),
    ?_assertEqual(encode([]), []),
    ?_assertException(error, function_clause, encode(<<"test">>)),
    ?_assertException(error, function_clause, encode({})), 
    ?_assertException(error, function_clause, encode(atom)),
    ?_assertException(error, function_clause, encode(12))
    ].
