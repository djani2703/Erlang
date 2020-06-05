-module(bs03).
-export([split/2]).


split(Bin, Sep) ->
    case is_binary(Bin) of
        true ->
            split(Bin, <<>>, [], list_to_binary(Sep), byte_size(list_to_binary(Sep)));
        false ->
            {error, not_a_binary}
    end.
    
    
split(Bin, AccBin, AccFin, Sep, SepSize) when Bin /= <<>> ->
    case Bin of
        <<Sep:SepSize/binary, Rest/binary>> ->
            split(Rest, <<>>, [AccBin|AccFin], Sep, SepSize);
        <<C/utf8, Rest/binary>> ->
            split(Rest, <<AccBin/binary, C/utf8>>, AccFin, Sep, SepSize)
    end;

    
split(<<>>, AccBin, AccFin, _, _) ->
    if 
        AccBin /= <<>> ->
            lists:reverse([AccBin|AccFin]);
        true ->
            lists:reverse(AccFin)
    end.
