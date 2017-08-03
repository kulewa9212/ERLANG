%%% @author matt <>
%%% @copyright (C) 2016, matt
%%% @doc
%%%
%%% @end
%%% Created : 11 Dec 2016 by matt <>

-module(echo).
-export([start/0, loop/0, timer/0, timer/1]).

start() ->
    register(echo, spawn(?MODULE, loop, [])),
    echo ! {self(), echo},
    receive
	{Pid, Msg} ->
	    io:format("Got ~p from ~p~n", [Msg, Pid])
    end,
    echo ! stop.

loop() ->
    receive
	{From, Msg} ->
	    From ! {self(), Msg},
	    loop();
	stop ->
	    ok
    end.

timer() ->
    spawn(?MODULE, timer, [self()]).

timer(Pid) ->
    receive
    after
        5000 ->
            Pid ! timeout
    end.
