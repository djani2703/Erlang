-module(bs01).
-export([first_word/1]).


first_word(Bin) ->
    first_word(Bin, <<>>).


first_word(<<" "/utf8, _/binary>>, Acc) ->
    Acc;

first_word(<<C/utf8, Rest/binary>>, Acc) ->
    first_word(Rest, <<Acc/binary, C/utf8>>);

first_word(<<>>, Acc) ->
    Acc.
