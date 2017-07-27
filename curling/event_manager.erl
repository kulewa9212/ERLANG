-module(event_manager).

-export([start/2, stop/1]).
-export([add_handler/3, delete_handler/2, get_data/2, send_event/3]).
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
call(Name, {add_handler, Handler, InitData},[]).

delete_handler(Name, Handler) ->
call(Name, {delete_handler, Handler},[]).

get_data(Name, Handler) ->
call(Name, {get_data, Handler},[]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

send_event(Name,[Team1,Team2],match) ->
call(Name,{match},[Team1,Team2]);
send_event(Name,[Team,Points],points) -> 
call(Name,{points},[Team,Points]).

call(Name,{match},[Team1,Team2]) ->
Name ! {match, self(),[Team1,Team2]},
receive {reply, Reply} -> Reply end ;
call(Name,{points},[Team,Points])->
Name ! {points, self(),[Team,Points]},
receive {reply, Reply} -> Reply end .




loop(State) ->
receive
{match, From,[Team1,Team2]} ->
{Reply, NewState} = handle_msg(State,match,[Team1,Team2]),
reply(From, Reply),
loop(NewState);
{points, From,[Team,Points]} ->
{Reply, NewState} = handle_msg(State,points,[Team,Points]),
reply(From, Reply),
loop(NewState);
{stop, From} ->
reply(From, terminate(State))
end.

handle_msg(LoopData,match,[Team1,Team2]) ->{ok, event(LoopData,match,[Team1,Team2])};
handle_msg(LoopData,points,[Team,Points]) ->{ok, event(LoopData,points,[Team,Points])}.




event([],_,_) -> [];
event([Handler|Rest],match,[Team1,Team2]) ->
[ Handler:handle_event({set_teams, Team1, Team2})|event(Rest,match,[Team1,Team2])];
event([Handler|Rest],points,[Team,Points]) ->
[ Handler:handle_event({add_points, Team, Points})].
% Handler:handle_event({add_points, Team, Points})
% [ 1|event(Rest,points,[Team,Points])].

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












