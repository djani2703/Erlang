-module(p15).
-export([replicate/2]).
-import('p05', [reverse/1]).
-include_lib("eunit/include/eunit.hrl").


replicate(L, N) when N >= 0 ->
    replicate(L, N, N, []).


replicate([], _, _, Acc) ->
    reverse(Acc);

replicate([_|Xs], N, 0, Acc) ->
    replicate(Xs, N, N, Acc);

replicate([X|_Xs], N, I, Acc) ->
    replicate([X|_Xs], N, I-1, [X|Acc]). 
    

replicate_test_() -> [
    ?_assertEqual(replicate([5,"test",atom,<<"bin">>], 2), [5,5,"test","test",atom,atom,<<"bin">>,<<"bin">>]),
    ?_assertEqual(replicate([], 5), []),
    ?_assertEqual(replicate([a, 125], 0), []),
    ?_assertException(error, function_clause, replicate(<<"bin">>, 3)),
    ?_assertException(error, function_clause, replicate({}, 3)), 
    ?_assertException(error, function_clause, replicate(true, 3)),
    ?_assertException(error, function_clause, replicate(5, 3))
    ].
