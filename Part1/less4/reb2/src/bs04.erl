-module(bs04).
-export([decode/2]).
-import('bs00', [to_object/1]). 


decode(JSON, proplist) ->
    decode(JSON, [], <<>>, [], [], proplist).
    
    
decode(<<>>, _, _, _, AccFin, proplist) ->
    AccFin;
     
     
decode(<<"{"/utf8, Rest/binary>>, Stack, AccBin, AccCurr, AccFin, proplist) ->
    case length(Stack) of
        0 -> 
            [Rest1, AccFin1] = decode(Rest, ["{"|Stack], <<>>, [], [], proplist),
            decode(Rest1, Stack, AccBin, AccCurr, AccFin1, proplist);
        _ ->
            case lists:nth(1, Stack) of
                "[" ->
                    decode(<<"{"/utf8, Rest/binary>>, ["fb"|Stack], AccBin, AccCurr, AccFin, proplist);
                _ ->
                    [Rest1, AccFin1] = decode(Rest, ["{"|Stack], <<>>, [], [], proplist),
                    decode(Rest1, Stack, AccBin, [AccFin1|AccCurr], AccFin, proplist)
            end
    end;

    
decode(<<"}"/utf8, Rest/binary>>, Stack, AccBin, AccCurr, AccFin, proplist) ->      
    if
        AccBin /= <<>> ->
            decode(<<",}"/utf8, Rest/binary>>, Stack, AccBin, AccCurr, AccFin, proplist);
        length(AccCurr) > 0 ->
            decode(<<"}"/utf8, Rest/binary>>, Stack, AccBin, [], [list_to_tuple(lists:reverse(AccCurr))|AccFin], proplist);        true ->
                [Rest, lists:reverse(AccFin)]
    end;
    
    
decode(<<"["/utf8, Rest/binary>>, Stack , AccBin, AccCurr, AccFin, proplist) ->
    [Rest1, AccFin1] = decode(Rest, ["["|Stack], <<>>, [], [], proplist),
    decode(Rest1, Stack, AccBin, [AccFin1|AccCurr], AccFin, proplist);
 
 
decode(<<"]"/utf8, Rest/binary>>, Stack, AccBin, AccCurr, AccFin, proplist) ->
    case lists:nth(1, Stack) of
        "sq" ->
            decode(<<"]"/utf8, Rest/binary>>, tl(Stack), <<>>, [], lists:reverse([AccBin|AccCurr]), proplist);
        "fb" -> 
            decode(<<"]"/utf8, Rest/binary>>, tl(Stack), <<>>, [], lists:reverse(AccCurr), proplist);
        _ ->
            [Rest, AccFin]
    end;
    
    
decode(<<","/utf8, Rest/binary>>, Stack, AccBin, AccCurr, AccFin, proplist) ->
    case lists:nth(1, Stack) of
        "fb" -> 
            decode(Rest, Stack, <<>>, AccCurr, AccFin, proplist);
        "sq" ->
            decode(Rest, Stack, <<>>, [AccBin|AccCurr], AccFin, proplist);
        "#"  ->
            decode(Rest, tl(Stack), <<>>, [], [list_to_tuple(lists:reverse([to_object(AccBin)|AccCurr]))|AccFin], proplist);
        _ ->
            decode(Rest, Stack, <<>>, [], [list_to_tuple(lists:reverse([AccBin|AccCurr]))|AccFin], proplist)
    end;
 
 
decode(<<":"/utf8, Rest/binary>>, Stack, AccBin, AccCurr, AccFin, proplist) ->
    decode(Rest, Stack, <<>>, [AccBin|AccCurr], AccFin, proplist);
    

decode(<<" "/utf8, Rest/binary>>, Stack, AccBin, AccCurr, AccFin, proplist) ->
    case lists:nth(1, Stack) of
        "'" ->
            decode(Rest, Stack, <<AccBin/binary, " "/utf8>>, AccCurr, AccFin, proplist);
        _ ->
            decode(Rest, Stack, AccBin, AccCurr, AccFin, proplist)
    end;
 
 
decode(<<"'"/utf8, Rest/binary>>, Stack, AccBin, AccCurr, AccFin, proplist) ->
    case lists:nth(1, Stack) of
        "[" ->
            decode(<<"'"/utf8, Rest/binary>>, ["sq"|Stack], AccBin, AccCurr, AccFin, proplist);
        "'" ->
            decode(Rest, tl(Stack), AccBin, AccCurr, AccFin, proplist);
        _ ->
            decode(Rest, ["'"|Stack], AccBin, AccCurr, AccFin, proplist)
    end; 

    
decode(<<C/utf8, Rest/binary>>, Stack, AccBin, AccCurr, AccFin, proplist) ->
    Elm = lists:nth(1, Stack),
    if 
        (Elm == "'") or (Elm == "#") ->
            decode(Rest, Stack, <<AccBin/binary, C/utf8>>, AccCurr, AccFin, proplist);
        true ->
            decode(Rest, ["#"|Stack], <<AccBin/binary, C/utf8>>, AccCurr, AccFin, proplist)
    end.
