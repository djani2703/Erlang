-module(p04).
-export([len/1]).


len([]) ->
    0;

len([_|Xs]) ->
    1 + len(Xs).
