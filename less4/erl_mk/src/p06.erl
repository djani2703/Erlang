-module(p06).
-export([is_palindrome/1]).
-import(p05, [reverse/1]).
-include_lib("eunit/include/eunit.hrl").


is_palindrome(L) ->
    L == reverse(L).

    
is_palindrome_test() ->
    ?assertEqual(is_palindrome("test"), false),
    ?assertEqual(is_palindrome("helleh"), true),
    ?assertEqual(is_palindrome([1, 'a', "hello", <<"bin">>]), false),
    ?assertEqual(is_palindrome([125, 'b', "qwerty", 'b', 125]), true),
    ?assertException(error, function_clause, is_palindrome(<<"bin">>)),
    ?assertException(error, function_clause, is_palindrome({})), 
    ?assertException(error, function_clause, is_palindrome(atom)),
    ?assertException(error, function_clause, is_palindrome(125)).
