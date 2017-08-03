%%% @author matt <>
%%% @copyright (C) 2016, matt
%%% @doc
%%% A simple database (list of records)
%%% using IO for user interface and
%%% recursion for holding the data.
%%% User interface is printed at start:
%%% io:format("Enter command:~n"
%%%       "A - add new user~n"
%%%       "D - delete user by last name~n"
%%%       "L - list all users~n"
%%%       "F - find user~n"
%%%       "Q - quit program~n"),
%%% @end
%%% Created : 13 Dec 2016 by matt <>

-module(db2).

-export([start/0, start/1]).

-record(person, {
	  firstname,
	  lastname,
	  street
	 }).
%% API
start() ->
    start([]).

start(List) ->
    main_loop(List, ok).

%% private functions
main_loop(List, quit) ->
    List;
main_loop(List, Flag) ->
	io:format("Enter command:~n"
		  "A - add new user~n"
		  "D - delete user by last name~n"
		  "L - list all users~n"
		  "F - find user~n"
		  "Q - quit program~n"),
    {NewList, NewFlag} =
	case io:fread('>', "~c") of
	    {ok, ["A"]} ->
		AddList = add_user(List),
		{AddList, Flag};
	    {ok, ["D"]} ->
		DelList = delete_user(List, lastname),
		{DelList, Flag};
	    {ok, ["L"]} ->
		io:format("All users:~n"
			  "~p~n", [List]),
		{List, Flag};
	    {ok, ["F"]} ->
		lookup(List),
		{List, Flag};
	    {ok, ["Q"]} ->
		{List, quit};
	    {ok, _} ->
		io:format("Wrong command, try again~n"),
		{List, Flag};
	    {error, _Err} ->
		io:format("Wrong command, try again~n"),
		{List, Flag}
	end,
    main_loop(NewList, NewFlag).

add_user(List) ->
    io:format("Enter first name~n"),
    {ok, [FirstName]} = io:fread('>', "~s"),
    io:format("Enter last name~n"),
    {ok, [LastName]} = io:fread('>', "~s"),
    io:format("Enter street~n"),
    {ok, [Street]} = io:fread('>', "~s"),
    NewUser = #person{
		 firstname = FirstName,
		 lastname = LastName,
		 street = Street
		},
    io:format("User ~p added~n", [NewUser]),
    lists:sort([NewUser | List]).

delete_user(List, lastname) ->
    io:format("Enter last name~n"),
    {ok, [LastName]} = io:fread('>', "~s"),
    NewList = lists:keydelete(LastName, 3, List),
    NewList.

%% would be neat to use Variables for keys in records, for example:
%% Where = lastname,
%% OldUser#user{Where = Data}
%% but compiler complains: field 'Where' is not an atom or _ in record user


lookup(List) ->
    io:format("Enter last name~n"),
    {ok, [LastName]} = io:fread('>', "~s"),
    case lists:keyfind(LastName, 3, List) of
	#person{lastname = LN,
		firstname = FN,
		street = S} ->
	    io:format("User found,~n"
		      "~p ~p,~n"
		      "street: ~p~n",
		      [FN, LN, S]);
	false ->
	    io:format("User not found~n")
    end.
