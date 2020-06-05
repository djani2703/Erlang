-module(benchmark).
-export([start/0, repeat1000/3]).
-export([create_maps/0, update_maps/1, remove_from_maps/1, read_from_maps/1, pattern_matching_for_maps/1]).
-export([create_proplists/0, update_proplists/1, remove_from_proplists/1, read_from_proplists/1]).  
-export([create_dict/0, update_dict/1, remove_from_dict/1, read_from_dict/1]).  
-export([create_proc_dict/0, update_proc_dict/0, remove_from_proc_dict/0, read_from_proc_dict/0]).    
-export([create_ets/0, update_ets/1, remove_from_ets/1, read_from_ets/1]).


start() ->
    N = 1000,
    io:format("---------------------------~n"),
    io:format(" Running 1000 tests | Res  ~n"),
    io:format("---------------------------~n"),
    io:format("Create maps         | ~p~n", [repeat1000(N, create_maps, 0)/N]),
    io:format("Update maps         | ~p~n", [repeat1000(N, update_maps, create_maps())/N]),
    io:format("Remove from maps    | ~p~n", [repeat1000(N, remove_from_maps, create_maps())/N]),
    io:format("Read from maps      | ~p~n", [repeat1000(N, read_from_maps, create_maps())/N]),
    io:format("PMatching for maps  | ~p~n", [repeat1000(N, pattern_matching_for_maps, create_maps())/N]),
    io:format("---------------------------~n"),
    io:format("Create proplists    | ~p~n", [repeat1000(N, create_proplists, 0)/N]),
    io:format("Update proplists    | ~p~n", [repeat1000(N, update_proplists, create_proplists())/N]),
    io:format("Remove from plists  | ~p~n", [repeat1000(N, remove_from_proplists, create_proplists())/N]),
    io:format("Read from proplists | ~p~n", [repeat1000(N, read_from_proplists, create_proplists())/N]),
    io:format("---------------------------~n"),
    io:format("Create dict         | ~p~n", [repeat1000(N, create_dict, 0)/N]),
    io:format("Update dict         | ~p~n", [repeat1000(N, update_dict, create_dict())/N]),
    io:format("Remove from dict    | ~p~n", [repeat1000(N, remove_from_dict, create_dict())/N]),
    io:format("Read from dict      | ~p~n", [repeat1000(N, read_from_dict, create_dict())/N]),
    io:format("---------------------------~n"),
    io:format("Create proc dict    | ~p~n", [repeat1000(N, create_proc_dict, 0)/N]),
    io:format("Update proc dict    | ~p~n", [repeat1000(N, update_proc_dict, 0)/N]),
    io:format("Remove from pr dict | ~p~n", [repeat1000(N, remove_from_proc_dict, 0)/N]),
    io:format("Read from proc dict | ~p~n", [repeat1000(N, read_from_proc_dict, 0)/N]),
    io:format("---------------------------~n"),
    io:format("Create ets          | ~p~n", [repeat1000(N, create_ets, 0)/N]),
    io:format("Update ets          | ~p~n", [repeat1000(N, update_ets, create_ets())/N]),
    io:format("Remove from ets     | ~p~n", [repeat1000(N, remove_from_ets, create_ets())/N]),
    io:format("Read from ets       | ~p~n", [repeat1000(N, read_from_ets, create_ets())/N]),
    io:format("---------------------------~n").
    
    
repeat1000(0, _, _) ->
    0;
    
repeat1000(N, FunName, Arg) when N > 0 ->
    case is_integer(Arg) of
        true ->
            {MSec,_} = timer:tc(?MODULE, FunName, []),
            MSec + repeat1000(N-1, FunName, Arg);
        _ ->
            {MSec,_} = timer:tc(?MODULE, FunName, [Arg]),
            MSec + repeat1000(N-1, FunName, Arg)
    end.   
   
    
%MAPS
create_maps() -> 
    #{key1 => "Value 1"}.
    
update_maps(M) ->
    maps:update(key1, "New value 1", M).
    
remove_from_maps(M) ->
    maps:remove(key1, M).
        
read_from_maps(M) ->
    maps:get(key1, M).
    
pattern_matching_for_maps(M) ->
    #{key1 := _} = M.
    
    
%PROPLISTS
create_proplists() ->
    [{key1, "Value 1"}].
    
update_proplists(P) ->
    [{key1, "New value 1"} | P].
    
remove_from_proplists(P) ->
    proplists:delete(key1, P).
    
read_from_proplists(P) ->
    proplists:get_value(key1, P).
    
    
%DICT
create_dict() ->
    D = dict:new(), 
    dict:store(key1, "Value 1", D).

update_dict(D) ->
    dict:store(key1, "New value 1", D).
    
remove_from_dict(D) ->
    dict:erase(key1, D).
    
read_from_dict(D) ->
    dict:fetch(key1, D).
    
    
%PROCESS DICTIONARY
create_proc_dict() ->
    put(key1, "Value 1").
    
update_proc_dict() ->
    put(key1, "New value 1").
    
remove_from_proc_dict() ->
    erase(key1).

read_from_proc_dict() ->
    get(key1).

    
%ETS
create_ets() ->
    Tab = ets:new(newTable, [set]),
    ets:insert(Tab, {key1, "Value 1"}),
    Tab.

update_ets(E) ->
    ets:insert(E, {key1, "New value 1"}).

remove_from_ets(E) ->
    ets:delete(E, key1).

read_from_ets(E) ->
    ets:lookup(E, key1).
