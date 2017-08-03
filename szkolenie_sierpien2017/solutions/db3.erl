%%% @author matt <>
%%% @copyright (C) 2016, matt
%%% @doc
%%% A simple database server
%%% @end
%%% Created : 15 Dec 2016 by matt <>

-module(db3).

-export([start/0, start/1, init/1]).
-export([add/1, del/1, lookup/1, list/0, stop/0]).

-record(person,
	{firstname,
	 lastname,
	 street}).
%% API

%% @doc
%% Starts the server process and initializes the Db.
%% @end
-spec start() -> true.
start() ->
    start([]).

-spec start(Db) -> true when Db :: [#person{}].
start(Db) when is_list(Db) ->
    erlang:register(?MODULE, spawn(?MODULE, init, [Db])).

%% @doc
%% Adds a #person{} record to the Db
%% @end
-spec add(Rec) -> ok when Rec :: #person{}.
add(Rec) ->
    Req = {add, Rec},
    cast(Req).

%% @doc
%% Removes a given #person{} from the Db
%% @end
-spec del(Rec) -> ok when Rec :: #person{}.
del(Rec) ->
    Req = {del, Rec},
    cast(Req).

%% @doc
%% Searches the Db for records of type #person{} - the key is
%% #person.lastname - and returns the first matching element or
%% atom 'undefined' if no matching occurs.
%% @end
-spec lookup(LastName) -> Result when LastName :: string() | term(),
				      Result :: #person{} | undefined.
lookup(LastName) ->
    Req = {lookup, LastName},
    call(Req, self()).


-spec list() -> Result when Result :: [#person{}] | [].
list() ->
    Req = list,
    call(Req, self()).

-spec stop() -> ok.
stop() ->
    Req = stop,
    cast(Req).

%% Callbacks
init(Db) ->
    loop(Db).

cast(Req) ->
    ?MODULE ! Req,
    ok.

call(Req, From) ->
    ?MODULE ! {From, Req},
    receive
	Reply ->
	    Reply
    end.

%% Server main loop
loop(Db) ->
    receive
	{add, #person{} = Rec} ->
	    loop([Rec | Db]);
	{del, LN} ->
	    loop(lists:keydelete(LN, #person.lastname, Db));
	{From, {lookup, LN}} ->
	    From ! lists:keyfind(LN, #person.lastname, Db),
	    %% TODO: return all records matching the pattern
	    loop(Db);
	{From, list} ->
	    From ! Db,
	    loop(Db);
        stop ->
	    terminate(Db)
    end.

terminate(Db) ->
    io:format("Goodbye, ~p~n", [Db]).
