-module(curling_scoreboard).
-behaviour(gen_event).
 
-export([init/1, handle_event/1, handle_call/2, handle_info/2, code_change/3,
terminate/2]).
 
init([]) ->
{ok, []}.
 
handle_event({set_teams, TeamA, TeamB}) ->
curling_scoreboard_hw:set_teams(TeamA, TeamB),
{ok};
handle_event({add_points, Team, N}) ->
[curling_scoreboard_hw:add_point(Team) || _ <- lists:seq(1,N)],
{ok};
handle_event(next_round) ->
curling_scoreboard_hw:next_round(),
{ok};
handle_event(_) ->
{ok}.
 
handle_call(_, State) ->
{ok, ok, State}.
 
handle_info(_, State) ->
{ok, State}.

code_change(_OldVsn, State, _Extra) ->
{ok, State}.
 
terminate(_Reason, _State) ->
ok.