-module(p05).
-export([reverse/1]).
-include_lib("eunit/include/eunit.hrl").


reverse(L) ->
    reverse(L, []).


reverse([], Acc) ->
    Acc;

reverse([X|Xs], Acc) ->
    reverse(Xs, [X|Acc]).

    
reverse_test() ->
    ?assertEqual(reverse([]), []),
    ?assertEqual(reverse([99, "test", 'a', <<"bin">>]), [<<"bin">>, 'a', "test", 99]),
    ?assertEqual(reverse("qwerty"), "ytrewq"),
    ?assertException(error, function_clause, reverse(<<"bin">>)),
    ?assertException(error, function_clause, reverse({})), 
    ?assertException(error, function_clause, reverse(atom)),
    ?assertException(error, function_clause, reverse(125)).
