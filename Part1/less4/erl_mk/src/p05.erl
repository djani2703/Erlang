-module(p05).
-export([reverse/1]).
-include_lib("eunit/include/eunit.hrl").


reverse(L) ->
    reverse(L, []).


reverse([], Acc) ->
    Acc;

reverse([X|Xs], Acc) ->
    reverse(Xs, [X|Acc]).

    
reverse_test_() -> [
    ?_assertEqual(reverse([]), []),
    ?_assertEqual(reverse([99, "test", 'a', <<"bin">>]), [<<"bin">>, 'a', "test", 99]),
    ?_assertEqual(reverse("qwerty"), "ytrewq"),
    ?_assertException(error, function_clause, reverse(<<"bin">>)),
    ?_assertException(error, function_clause, reverse({})), 
    ?_assertException(error, function_clause, reverse(atom)),
    ?_assertException(error, function_clause, reverse(125))
    ].
