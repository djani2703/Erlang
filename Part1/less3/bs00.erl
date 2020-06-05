-module(bs00).
-export([to_object/1]).

to_object(Bin) -> 
    case binary_become_atom(Bin) of
        true  -> 
            binary_to_atom(Bin, utf8);
        false ->
            case binary_become_integer(Bin) of
                true ->
                    binary_to_integer(Bin);
                false ->
                    {error, not_atom_or_number}
            end
    end.


binary_become_atom(<<C/utf8, _/binary>>) ->
    (C > 96) and (C < 122).

    
binary_become_integer(<<>>) ->
    true;
    
binary_become_integer(<<C/utf8, Rest/binary>>) -> 
    ((C > 47) and (C < 58)) and binary_become_integer(Rest).
