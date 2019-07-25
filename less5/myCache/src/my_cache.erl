-module(my_cache).
-export([create/1, insert/4, lookup/2, delete_obsolete/1]).


curr_time() ->
    element(2, erlang:timestamp()).

    
create(TableName) ->
    try
        ets:new(TableName, [set, named_table]),
        ok
    catch 
        error:system_limit ->
            {error, undefined_table}
    end.
    
    
insert(TableName, Key, Value, LifeTime) ->
    try
        case is_integer(LifeTime) of
            true ->
                ets:insert(TableName, {Key, Value, curr_time() + LifeTime}), 
                ok;
            _ ->
                {error, lifeTime_value_is_incorrect}
        end
    catch
        error:badarg ->
            {error, tableName_is_incorrect}
    end.
    
    
lookup(TableName, Key) ->
    try
        {_, Value, LifeTime} = hd(ets:lookup(TableName, Key)),
        CurrTime = curr_time(),
        if 
            CurrTime =< LifeTime ->
                {ok, Value};
            true ->
                {old_ets_record}
        end
    catch
        error:badarg ->
            {error, value_of_tableName_or_key_is_incorrect}
    end.

        
delete_obsolete(TableName) ->
    try
        OldContent = ets:tab2list(TableName),
        NewContent = lists:filter(fun({_, _, LifeTime}) -> LifeTime >= curr_time() end, OldContent),
        ets:delete_all_objects(TableName),
        ets:insert(TableName, NewContent),
        ok
    catch
        error:badarg ->
            {error, tableName_is_incorrect}
    end.
