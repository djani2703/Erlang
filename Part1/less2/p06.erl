-module(p06).
-export([is_palindrome/1, is_palindrome1/1]).
-import(p05, [reverse/1]).


is_palindrome(L) ->
    L == reverse(L).


is_palindrome1(L) ->
    palindrome_log(L, reverse(L)).

palindrome_log(_L, _L) ->
    true;

palindrome_log(_L, _OL) ->
    false.
