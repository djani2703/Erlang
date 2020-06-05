-module(p06).
-export([is_palindrome/1]).
-import(p05, [reverse/1]).
-include_lib("eunit/include/eunit.hrl").


is_palindrome(L) ->
    L == reverse(L).

    
is_palindrome_test_() -> [
    ?_assertEqual(is_palindrome("test"), false),
    ?_assertEqual(is_palindrome("helleh"), true),
    ?_assertEqual(is_palindrome([1, 'a', "hello", <<"bin">>]), false),
    ?_assertEqual(is_palindrome([125, 'b', "qwerty", 'b', 125]), true),
    ?_assertException(error, function_clause, is_palindrome(<<"bin">>)),
    ?_assertException(error, function_clause, is_palindrome({})), 
    ?_assertException(error, function_clause, is_palindrome(atom)),
    ?_assertException(error, function_clause, is_palindrome(125))
    ].
