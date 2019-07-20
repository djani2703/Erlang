-module(p13).
-export([decode/1]).
-include_lib("eunit/include/eunit.hrl").


decode([]) ->
    [];

decode([{Cnt, Elm}|Xs]) ->
    decode([{Cnt, Elm}|Xs], 1).


decode([], _) ->
    [];

decode([{Cnt, Elm}|Xs], Cnt)  ->
    [Elm|decode(Xs, 1)];

decode([{Cnt, Elm}|Xs], I) ->
    [Elm|decode([{Cnt, Elm}|Xs], I+1)].

    
decode_test() ->
    ?assertEqual(decode([{1, a},{3, b},{2, c},{4, d},{1, f}]), [a,b,b,b,c,c,d,d,d,d,f]),
    ?assertEqual(decode([]), []),
    ?assertException(error, function_clause, decode(<<"test">>)),
    ?assertException(error, function_clause, decode({})), 
    ?assertException(error, function_clause, decode(atom)),
    ?assertException(error, function_clause, decode(12)).
