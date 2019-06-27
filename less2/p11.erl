-module(p11).
-export([encode_modified/1]).


encode_modified([]) ->
    [];

encode_modified([X|Xs]) ->
    start_encode([X|Xs], X, 0).


start_encode([], X, 1) ->
    [X];

start_encode([], X, Cnt) ->
    [{Cnt, X}];

start_encode([X|Xs], X, Cnt) ->
    start_encode(Xs, X, Cnt+1);

start_encode([X|Xs], Y, 1) ->
    [Y|start_encode(Xs, X, 1)];

start_encode([X|Xs], Y, Cnt) ->
    [{Cnt, Y}|start_encode(Xs, X, 1)].

















%%start_encode([], X, 1) ->
%%    [X];

%%start_encode([], X, Cnt) ->
%%    [{Cnt, X}];

%%start_encode([X|Xs], X, Cnt) ->
%%    start_encode([X|Xs], X, Cnt+1);

%%start_encode([X|Xs], Y, 1) ->
%%    [[Y] | start_encode(Xs, X, 1)];

%%start_encode([X|Xs], Y, Cnt) ->
%%    [{Cnt,Y} | start_encode(Xs, X, 1)].
