%%% @author matt <>
%%% @copyright (C) 2016, matt
%%% @doc
%%%
%%% @end
%%% Created : 15 Dec 2016 by matt <>

-module(calc).
-export([start/0, start/1, init/1, req/1, stop/0]).
-export([handle_req/1]).

%%API
start() ->
    start(normal).

start(Opt) ->
    erlang:register(?MODULE, spawn(?MODULE, init, [Opt])).

req(Req) ->
    ?MODULE ! {self(), Req},
    receive
	Reply ->
	    Reply
    end.

stop() ->
    ?MODULE ! stop.

%%Callbacks
init(normal) ->
    loop([]);
init(N) ->
    Pids = [ spawn_link(
	     fun Loop() ->
		     receive
			 {Ref, Req} when is_reference(Ref) ->
			     ?MODULE ! {Ref, ?MODULE:handle_req(Req)},
			     Loop();
			 stop -> ok
		     end
	     end) || _I <- lists:seq(1, N) ],
    loop(Pids).

loop(State) ->
    case State of
	[] ->
	    receive
		{From, Req} ->
		    From ! handle_req(Req),
		    loop(State);
		stop ->
		    ok
	    end;
	Pids ->
	    receive
		{From, Req} ->
		    Ref = make_ref(),
		    hd(Pids) ! {Ref, Req},
		    receive
			{Ref, Reply} ->
			    From ! Reply
		    end,
		    NewState = rotate(Pids),
		    loop(NewState);
		stop ->
		    ok
	    end
    end.

handle_req({'+', Args}) ->
    lists:sum(Args);
handle_req({'*', Args}) ->
    lists:foldl(fun (X, Acc) -> X * Acc end, 1, Args);
handle_req(_) ->
    {error, bad_request}.

rotate(List) ->
    lists:reverse([hd(List) | lists:reverse(tl(List))]).
