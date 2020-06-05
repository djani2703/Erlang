-module(bs02).
-export([words/1]).


words(Bin) ->
    lists:reverse(words(Bin, <<>>, [], false)).

            
words(<<C/utf8, Rest/binary>>, AccBin, AccRes, Log) ->
    case C of 
        32 ->
            if 
                Log == true ->
                    words(Rest, <<>>, [AccBin|AccRes], false);
                true ->
                    words(Rest, AccBin, AccRes, false)
            end;
        _ ->
            words(Rest, <<AccBin/binary, C/utf8>>, AccRes, true)
    end;

    
words(<<>>, AccBin, AccRes, _) ->
    if 
        AccBin /= <<>> ->
            [AccBin|AccRes];
        true ->
            AccRes
    end.
