-module(cache_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).
-export([start_link/2]).
-behaviour(gen_server).


start_link(TableName, [{drop_interval, Time}]) ->
	DropTime = Time * 1000, 
	gen_server:start_link({local, TableName}, ?MODULE, [TableName, DropTime], [timeout, 5000]).


init([TableName, DropTime]) ->
	create(TableName),
	self() ! {info, {delete_obsolete, {TableName, DropTime}}},
	State = ets:tab2list(TableName),
	{ok, State}.


handle_call({lookup_by_date, {TableName, DateFrom, DateTo}}, _From, State) ->
	Value = lookup_by_date(TableName, DateFrom, DateTo),
	{reply, {ok, Value}, State};

handle_call({lookup, {TableName, Key}}, _From, State) ->
	Value = lookup(TableName, Key),
	{reply, {ok, Value}, State};

handle_call(stop, _From, State) ->
	{reply, {stop, normal}, State};

handle_call(_, _From, State) ->
	{noreply, State}.


handle_cast({insert, {TableName, Key, Value, LifeTime}}, _State) ->
	NewState = insert(TableName, Key, Value, LifeTime),
	{noreply, NewState};

handle_cast(_, State) ->
	{noreply, State}.

handle_info({delete, {TableName, Key}}, _State) ->
	NewState = ets:delete(TableName, Key),
	{noreply, NewState};

handle_info({delete_obsolete, {TableName, DropTime}}, _State) ->	
	NewState = delete_obsolete(TableName),
	erlang:send_after(DropTime, self(), {info, {delete_obsolete, {TableName, DropTime}}}),
	{noreply, NewState};

handle_info(_, State) ->
	{noreply, State}.


terminate(normal, _State) ->
	ok;

terminate(Reason, _State) ->
	Reason.

	
current_time() ->
    element(2, erlang:timestamp()).

create(TableName) ->
    try
        ets:new(TableName, [set, named_table]),
        ok
    catch 
        error:badarg ->
            {error, table_already_created}
    end.

insert(TableName, Key, Value, LifeTime) ->
    try
        case is_integer(LifeTime) of
            true ->
                ets:insert(TableName, {Key, Value, current_time() + LifeTime}), 
                ok;
            _ ->
                {error, lifeTime_value_is_incorrect}
        end
    catch
        error:badarg ->
            {error, tableName_is_incorrect}
    end.



delete_obsolete(TableName) ->
    try
        OldContent = ets:tab2list(TableName),
        NewContent = lists:filter(fun({_, _, LifeTime}) -> LifeTime >= current_time() end, OldContent),
        ets:delete_all_objects(TableName),
        ets:insert(TableName, NewContent),
        ok
    catch
        error:badarg ->
            {error, tableName_is_incorrect}
    end.

lookup(TableName, Key) ->
    try
        {_, Value, LifeTime} = hd(ets:lookup(TableName, Key)),
        CurrTime = current_time(),
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

lookup_by_date(TableName, DateFrom={FromDate,{FromHour,FromMin,FromSec}}, DateTo={ToDate,{ToHour,ToMin,ToSec}}) when
	is_integer(FromHour), 
	is_integer(FromMin), 
	is_integer(FromSec), 
	is_integer(ToHour), 
	is_integer(ToMin), 
	is_integer(ToSec) ->
	case calendar:valid_date(FromDate) andalso calendar:valid_date(ToDate) of
		true ->
			try
				Content = ets:tab2list(TableName),
				LookupContent = lists:filter(fun({_, _, CreationDate, _}) ->
        			calendar:datetime_to_gregorian_seconds(CreationDate) >= calendar:datetime_to_gregorian_seconds(DateFrom) andalso 
        			calendar:datetime_to_gregorian_seconds(CreationDate) =< calendar:datetime_to_gregorian_seconds(DateTo) end, 
        			Content),
				LookupContent
			catch
				error:badarg -> 
					io:format("Bad TableName argument:~p ~n", [TableName])
			end;
		_ ->
			io:format("DateFrom or DateTo isn't valid!")
	end;

lookup_by_date(_TableName, _DateFrom, _DateTo) ->
	io:format("Wrong DateFrom or DateTo time argument!").
