-module(p04).
-export([len/1]).
-include_lib("eunit/include/eunit.hrl").


len([]) ->
    0;

len([_|Xs]) ->
    1 + len(Xs).

    
len_test_() -> [
    ?_assertEqual(len([99, "test", 'a', <<"bin">>, b]), 5),
    ?_assertEqual(len("qwerty"), 6),
    ?_assertEqual(len([]), 0),
    ?_assertException(error, function_clause, len(<<"bin">>)),
    ?_assertException(error, function_clause, len({})), 
    ?_assertException(error, function_clause, len(atom)),
    ?_assertException(error, function_clause, len(125))
    ].
