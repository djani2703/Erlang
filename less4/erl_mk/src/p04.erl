-module(p04).
-export([len/1]).
-include_lib("eunit/include/eunit.hrl").


len([]) ->
    0;

len([_|Xs]) ->
    1 + len(Xs).

    
len_test() ->
    ?assertEqual(len([99, "test", 'a', <<"bin">>, b]), 5),
    ?assertEqual(len("qwerty"), 6),
    ?assertEqual(len([]), 0),
    ?assertException(error, function_clause, len(<<"bin">>)),
    ?assertException(error, function_clause, len({})), 
    ?assertException(error, function_clause, len(atom)),
    ?assertException(error, function_clause, len(125)).
