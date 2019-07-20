-module(p03).
-export([element_at/2]).
-include_lib("eunit/include/eunit.hrl").


element_at([X|_], 1) ->
    X;

element_at([_|Xs], N) ->
    element_at(Xs, N-1);

element_at([], _) ->
    undefined.

element_at_test_() -> [
    ?_assertEqual(element_at([99, "test", 'a', <<"bin">>, b], -100), undefined),
    ?_assertEqual(element_at(['b', 17, <<"a binary">>, 109, "qwert"], 100), undefined),
    ?_assertEqual(element_at(['a', "hello", 55, <<"bin">>, 199], 2), "hello"),
    ?_assertException(error, function_clause, element_at(<<"bin">>, 1)),
    ?_assertException(error, function_clause, element_at({}, 1)), 
    ?_assertException(error, function_clause, element_at(atom, 1)),
    ?_assertException(error, function_clause, element_at(125, 1))
    ].
