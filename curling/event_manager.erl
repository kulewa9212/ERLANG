-module(event_manager).

-export([start/2, stop/1]).
-export([add_handler/3, delete_handler/2, get_data/2, send_event/1]).
-export([init/1]).

start(Name, HandlerList) ->
register(Name, spawn(event_manager, init, [HandlerList])),
ok.

init(HandlerList) ->
loop(HandlerList).

initialize([]) -> [];
% initialize([{Handler, InitData}|Rest]) ->
% [{Handler, Handler:init([])}|initialize(Rest)].
initialize([Handler|Rest]) ->
 [Handler:init([])|initialize(Rest)].


stop(Name) ->
Name ! {stop, self()},
receive {reply, Reply} -> Reply end.

terminate([]) -> [];
terminate([{Handler, Data}|Rest]) ->
[{Handler, Handler:terminate(Data)}|terminate(Rest)].

add_handler(Name, Handler, InitData) ->
call(Name, {add_handler, Handler, InitData}).

delete_handler(Name, Handler) ->
call(Name, {delete_handler, Handler}).

get_data(Name, Handler) ->
call(Name, {get_data, Handler}).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

send_event(Name) ->
call(Name,{send_event}).

call(Name,{send_event}) ->
Name ! {request, self()},
receive {reply, Reply} -> Reply end.

loop(State) ->
receive
{request, From} ->
{Reply, NewState} = handle_msg(State),
reply(From, Reply),
loop(NewState);
{stop, From} ->
reply(From, terminate(State))
end.

handle_msg(LoopData) ->{ok, event(LoopData)}.

event([]) -> [];
event([Handler|Rest]) ->
[ Handler:handle_event({set_teams, "A", "B"})|event(Rest)].

%Handler:handle_event({set_teams, "team A", "team B"}, done)%















%%handle_msg({add_handler, Handler, InitData}, LoopData) ->
%%{ok, [{Handler, Handler:init(InitData)}|LoopData]};
%handle_msg({delete_handler, Handler}, LoopData) ->
%case lists:keysearch(Handler, 1, LoopData) of
%false ->
%{{error, instance}, LoopData};
%{value, {Handler, Data}} ->
%Reply = {data, Handler:terminate(Data)},
%NewLoopData = lists:keydelete(Handler, 1, LoopData),
%{Reply, NewLoopData}
%end;
%handle_msg({get_data, Handler}, LoopData) ->
%case lists:keysearch(Handler, 1, LoopData) of
%false -> {{error, instance}, LoopData};
%{value, {Handler, Data}} -> {{data, Data}, LoopData}
%end;
%handle_msg({send_event, Event}, LoopData) ->{ok, event(Event, LoopData)}.







reply(To, Msg) ->
To ! {reply, Msg}.












