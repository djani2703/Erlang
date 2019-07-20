-module(p02).
-export([but_last/1]).
-include_lib("eunit/include/eunit.hrl").

but_last([_,_] = List) ->
    List;

but_last([_|Xs]) ->
    but_last(Xs).


but_last_test() ->
    ?assertEqual(but_last([12, 34, 'a', 78, 32]), [78, 32]),
    ?assertEqual(but_last([34, 11, 97, 109]), "am"),
    ?assertEqual(but_last("test"), [115, 116]),
    ?assertEqual(but_last([a, b, c, f, q, z]), [q, z]),
    ?assertEqual(but_last([a, 13, <<"Bin">>,'q',"new"]), ['q', "new"]),
    ?assertException(error, function_clause, but_last(<<>>)),
    ?assertException(error, function_clause, but_last({})), 
    ?assertException(error, function_clause, but_last([])),
    ?assertException(error, function_clause, but_last([123])),
    ?assertException(error, function_clause, but_last(atom)),
    ?assertException(error, function_clause, but_last(5)).
