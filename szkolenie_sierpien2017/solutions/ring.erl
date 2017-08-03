%%% @author matt <>
%%% @copyright (C) 2016, matt
%%% @doc
%%%
%%% @end
%%% Created : 15 Dec 2016 by matt <>

-module(ring).

-export([start/3, proc/4]).

start(M, N, Message) ->
    proc(M, N, Message, self()).

proc(M, 0, Message, StartPid) ->
    StartPid ! {Message, M, self(), StartPid},
    loop(M, Message, StartPid);
proc(M, N, Message, StartPid) ->
    NPid = spawn(?MODULE, proc, [M, N-1, Message, StartPid]),
    loop(M, Message, NPid).

loop(0, _Message, Pid) ->
    Pid ! stop,
    receive
	stop -> ok
    end;
loop(M, Message, Pid) ->
    receive
	stop ->
	    Pid ! stop;
	{Msg, Cnt, From, To} ->
	    io:format("Msg:~p nr:~p from ~p to ~p~n",
		      [Msg, Cnt, From, To]),
	    Pid ! {Message, M, self(), Pid},
	    loop(M-1, Message, Pid)
    end.

