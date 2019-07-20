-module(p11).
-export([encode_modified/1]).
-include_lib("eunit/include/eunit.hrl").


encode_modified([]) ->
    [];

encode_modified([X|Xs]) ->
    encode_modified([X|Xs], X, 0).


encode_modified([], X, 1) ->
    [X];

encode_modified([], X, Cnt) ->
    [{Cnt, X}];

encode_modified([X|Xs], X, Cnt) ->
    encode_modified(Xs, X, Cnt+1);

encode_modified([X|Xs], Y, 1) ->
    [Y|encode_modified(Xs, X, 1)];

encode_modified([X|Xs], Y, Cnt) ->
    [{Cnt, Y}|encode_modified(Xs, X, 1)].


encode_modified_test_() -> [
    ?_assertEqual(encode_modified([a, a, a, b, c, c, d, d, d, e]), [{3, a}, b, {2, c}, {3, d}, e]),
    ?_assertEqual(encode_modified("hello"), [104, 101, {2, 108}, 111]),
    ?_assertEqual(encode_modified([]), []),
    ?_assertException(error, function_clause, encode_modified(<<"test">>)),
    ?_assertException(error, function_clause, encode_modified({})), 
    ?_assertException(error, function_clause, encode_modified(atom)),
    ?_assertException(error, function_clause, encode_modified(12))
    ].
