-module(p09).
-export([pack/1]).
-include_lib("eunit/include/eunit.hrl").


pack([]) ->
    [];

pack([X|Xs]) -> 
    pack([X|Xs], X, []).

    
pack([], _, Acc) ->
    [Acc];

pack([X|Xs], X, Acc) ->
    pack(Xs, X, [X|Acc]);

pack([X|Xs], _Xd, Acc) ->
    [Acc | pack(Xs,X,[X])].

    
pack_test() ->
    ?assertEqual(pack([a, a, a, b, c, c, d, d, d, e]), [[a, a, a], [b], [c, c], [d, d, d], [e]]),
    ?assertEqual(pack("hello"), ["h", "e", "ll", "o"]),
    ?assertEqual(pack([]), []),
    ?assertException(error, function_clause, pack(<<"bin">>)),
    ?assertException(error, function_clause, pack({})), 
    ?assertException(error, function_clause, pack(atom)),
    ?assertException(error, function_clause, pack(125)).
