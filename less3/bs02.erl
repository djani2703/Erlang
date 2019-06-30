-module(bs02).
-export([words/1]).


clear_and_reverse([X|Xs], Acc) ->
    if
        X /= <<>> -> clear_and_reverse(Xs, [X|Acc]);
        true -> clear_and_reverse(Xs, Acc)
    end;

clear_and_reverse([], Acc) ->
    Acc.


words(Bin) ->
    clear_and_reverse(words(Bin, [], <<>>), []).


words(<<" "/utf8, Rest/binary>>, AccL, AccB) ->
    words(Rest, [AccB | AccL], <<>>);

words(<<C/utf8, Rest/binary>>, AccL, AccB) ->
    words(Rest, AccL, <<AccB/binary, C/utf8>>);

words(<<>>, AccL, AccB) ->
    [AccB | AccL].
