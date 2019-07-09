-module(bs04).
-export([decode/2, detect_mode/1]).


decode(Json, proplist) ->
    <<C/utf8, _/binary>> = Json,
        case C of
            123 ->
                decode(Json, [], 1, <<>>, [], [], proplist);
            91  ->
                decode(Json, [], 2, <<>>, [], [], proplist);
            _   ->
                {error, error_start_symbol}
        end.
        
decode(<<>>, _Stack, _Mode, _AccB, _AccTL, AccL, proplist) ->
    lists:reverse(AccL);
  
        
decode(Json, Stack, Mode, AccB, AccTL, AccL, proplist) ->
    <<C/utf8, Rest/binary>> = Json,
    case C of 
        %% space
        32 ->
            case top_stack(Stack) of
                39 ->
                    decode(Rest, Stack, Mode, <<AccB/binary, C/utf8>>, AccTL, AccL, proplist);
                _  ->
                    decode(Rest, Stack, Mode, AccB, AccTL, AccL, proplist)
            end;
        %% '    
        39 ->
            case top_stack(Stack) of
                39 -> 
                    case Mode of
                        1 ->
                            decode(Rest, remove_from_stack(Stack), Mode, <<>>, [AccB | AccTL], AccL, proplist);
                        2 -> 
                            decode(Rest, remove_from_stack(Stack), Mode, <<>>, AccTL, [AccB | AccL], proplist)
                    end;
                _ ->
                    decode(Rest, add_to_stack(Stack, C), Mode, AccB, AccTL, AccL, proplist)
            end;
        %% ,
        44 ->
            case Mode of
                1 ->
                    case top_stack(Stack) of
                        35 ->
                            AccTLTemp = [to_object(AccB) | AccTL],
                            decode(Rest, remove_from_stack(Stack), Mode, <<>>, [], [list_to_tuple(lists:reverse(AccTLTemp)) | AccL], proplist);
                        _  ->
                            decode(Rest, Stack, Mode, AccB, [], [list_to_tuple(lists:reverse(AccTL)) | AccL], proplist)    
                    end;
                2 ->
                    decode(Rest, Stack, Mode, AccB, AccTL, AccL, proplist)
            end;
        %% :
        58 -> 
            decode(Rest, Stack, Mode, AccB, AccTL, AccL, proplist);
        %% [
        91 ->
            decode(Rest, add_to_stack(Stack, C), Mode+1, AccB, AccTL, AccL, proplist);
        %% ]
        93 ->
            StackNew = remove_from_stack(Stack),
            case Mode of
                1 ->
                    AccTLNew = [AccB | AccTL],
                    decode(Rest, StackNew, detect_mode(StackNew), <<>>, [], lists:reverse([AccTLNew | AccL]), proplist);
                2 ->
                    decode(Rest, StackNew, detect_mode(StackNew), <<>>, AccTL, AccL, proplist)
            end;
        %% {
        123 -> 
            decode(Rest, add_to_stack(Stack, C), 1, AccB, AccTL, AccL, proplist);
        %% }
        125 ->
            case top_stack(Stack) of
                35 -> 
                    AccTLNew = [to_object(AccB) | AccTL],
                    StackNew = remove_from_stack(remove_from_stack(Stack)),
                    decode (Rest, StackNew, detect_mode(StackNew), <<>>, [], [list_to_tuple(lists:reverse(AccTLNew)) | AccL], proplist);
                _  ->
                    StackNew = remove_from_stack(Stack),
                    decode(Rest, StackNew, detect_mode(StackNew), AccB, [], [list_to_tuple(lists:reverse(AccTL)) | AccL], proplist)
            end;
        %% other
        _   ->        
            case top_stack(Stack) of
                39 ->
                    decode(Rest, Stack, Mode, <<AccB/binary, C/utf8>>, AccTL, AccL, proplist);
                35 ->
                    decode(Rest, Stack, Mode, <<AccB/binary, C/utf8>>, AccTL, AccL, proplist);
                _  ->
                    decode(Rest, add_to_stack(Stack, 35), Mode, <<AccB/binary, C/utf8>>, AccTL, AccL, proplist),
                    case Mode of
                        1 ->
                            decode(Rest, add_to_stack(Stack, 35), Mode, <<AccB/binary, C/utf8>>, AccTL, AccL, proplist);
                        2 ->
                            decode(Rest, Stack, Mode, AccB, AccTL, AccL, proplist)
                    end
            end
    end.
    
   
   
   
%%-------------------------    
%%    BINARY SECTION       |
%%-------------------------

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

    
%%------------------------    
%%    STACK SECTION       |
%%------------------------

top_stack([X|_]) ->
    X.
    
add_to_stack(Stack, Elm) ->
    [Elm | Stack].
    
remove_from_stack([_|Xs]) ->
    Xs.  

    
detect_mode(Stack) ->
    if 
        Stack /= [] ->
            case top_stack(Stack) of
                "{" -> 1;
                "[" -> 2;
                _   -> {error, stack_mode_not_detected}
            end;
        true -> 1
    end.
