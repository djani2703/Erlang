-module(bs01).
-export([first_word/1]).


first_word(Bin) ->
    first_word(Bin, <<>>, false).

    
first_word(<<C/utf8, Rest/binary>>, AccBin, Log) when <<C/utf8, Rest/binary>> /= <<>> ->
    case C of 
        32 ->
            case Log of
                true ->
                    AccBin;
                false ->
                    first_word(Rest, AccBin, Log)
            end;
        _ ->
            first_word(Rest, <<AccBin/binary, C/utf8>>, true)
    end;
    
first_word(<<>>, AccBin, Log) ->
    case Log of
        true ->
            AccBin;
        false ->
            {error, not_content_to_show}
    end.
