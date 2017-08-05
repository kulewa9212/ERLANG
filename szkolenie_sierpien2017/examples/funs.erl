%%% @author matt <>
%%% @copyright (C) 2016, matt
%%% @doc
%%%
%%% @end
%%% Created : 10 Dec 2016 by matt <>

-module(funs).
-export([for/3]).

for(Max, Max, F) ->
    [F(Max)];
for(I, Max, F) ->
    [F(I) | for(I + 1, Max, F)].

