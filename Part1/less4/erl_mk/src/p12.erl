-module(p12).
-export([decode_modified/1]).
-include_lib("eunit/include/eunit.hrl").


decode_modified([]) ->
    [];

decode_modified([{Cnt, Elm}|Xs]) ->
    decode_modified([{Cnt, Elm}|Xs], 1);

decode_modified([Elm|Xs]) ->
    decode_modified([Elm|Xs], 1).


decode_modified([], _) ->
    [];

decode_modified([{Cnt, Elm}|Xs], Cnt)  ->
    [Elm|decode_modified(Xs, 1)];

decode_modified([{Cnt, Elm}|Xs], I) ->
    [Elm|decode_modified([{Cnt, Elm}|Xs], I+1)];

decode_modified([Elm|Xs], 1) ->
    [Elm|decode_modified(Xs, 1)].


decode_modified_test_() -> [
    ?_assertEqual(decode_modified([{4, a},{5, b},c,{2, d},{3, e},f]), [a,a,a,a,b,b,b,b,b,c,d,d,e,e,e,f]),
    ?_assertEqual(decode_modified([]), []),
    ?_assertException(error, function_clause, decode_modified(<<"test">>)),
    ?_assertException(error, function_clause, decode_modified({})), 
    ?_assertException(error, function_clause, decode_modified(atom)),
    ?_assertException(error, function_clause, decode_modified(12))
    ].
