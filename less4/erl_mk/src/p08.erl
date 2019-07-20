-module(p08).
-export([compress/1]).
-import('p05', [reverse/1]).
-include_lib("eunit/include/eunit.hrl").


compress([]) ->
    [];

compress([X1|Xs]) ->
    compress([X1|Xs], X1, []).


compress([], X, Acc) ->
    reverse([X|Acc]);

compress([X1|Xs], X1, Acc) ->
    compress(Xs, X1, Acc);

compress([X1|Xs], X, Acc) ->
    compress(Xs, X1, [X|Acc]).

    
compress_test_() -> [
    ?_assertEqual(compress([a, a, a, b, c, c, d, d, d, e]), [a, b, c, d, e]),
    ?_assertEqual(compress("hello"), "helo"),
    ?_assertEqual(compress([]), []),
    ?_assertException(error, function_clause, compress(<<"bin">>)),
    ?_assertException(error, function_clause, compress({})), 
    ?_assertException(error, function_clause, compress(atom)),
    ?_assertException(error, function_clause, compress(125))
    ].
