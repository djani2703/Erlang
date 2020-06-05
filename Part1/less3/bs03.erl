-module(bs03).
-export([split/2, del_split/2]).
-import('bs02', [clear_and_reverse/2]).


split(Bin, Spl) ->
    clear_and_reverse(split(Bin, Spl, [], <<>>), []).

split(<<>>, _, AccL, AccB) ->
    [AccB | AccL];

split(Bin, Spl, AccL, AccB) ->
    case is_split(Bin, Spl, length(Spl), []) of
        true ->
            split(del_split(Bin, length(Spl)), Spl, [AccB|AccL], <<>>);
        _->
            <<C/utf8, Rest/binary>> = Bin,
            split(Rest, Spl, AccL, <<AccB/binary, C/utf8>>)
    end.


is_split(<<>>, Spl, _, Acc) ->
    Spl == lists:reverse(Acc);

is_split(<<C/utf8, Rest/binary>>, Spl, Size, Acc) when Size > 0 ->
    is_split(Rest, Spl, Size-1, [C|Acc]);

is_split(_, Spl, 0, Acc) ->
    Spl == lists:reverse(Acc).


del_split(<<_C/utf8, Rest/binary>>, N) when N > 0 ; not <<>>  ->
    del_split(Rest, N-1);

del_split(Bin, 0) ->
    Bin.
