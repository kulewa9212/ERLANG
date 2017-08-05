%%% @author matt <>
%%% @copyright (C) 2016, matt
%%% @doc
%%%
%%% @end
%%% Created : 13 Dec 2016 by matt <>

-module(db1).
-export([add/2, del/2, lookup/2, lookup2/2, lookup3/2]).

-record(person, {
	  firstname,
	  lastname,
	  street
	 }).
%% Adds a record to a given list of records. Duplicate elements
%% are not replaced.
-spec add(Record, Db1) -> Db2 when Record :: #person{},
				   Db1 :: [#person{}],
				   Db2 :: [#person{}].
add(Record, Data) when is_record(Record, person), is_list(Data) ->
    [Record | Data].
%% Removes a given record from the list, if found.
-spec del(Record, Db1) -> Db2 when Record :: #person{},
				   Db1 :: [#person{}],
				   Db2 :: [#person{}] | [].
del(Record, Data) when is_record(Record, person), is_list(Data) ->
    Data -- [Record].
%% Searches the list of records of type #person{} - the key is
%% #person.lastname - and returns the first matching element or
%% atom 'undefined' if no matching occurs.
-spec lookup(LastName, list()) -> Result when LastName :: string() | term(),
					      Result :: #person{} | undefined.
lookup(LastName, Data) when is_list(Data) ->
    lists:keyfind(LastName, #person.lastname, Data).
%% Alternative version of lookup/2 using list comprehensions.
lookup2(LastName, Data) when is_list(Data) ->
    case [ X || X <- Data, X#person.lastname =:= LastName] of
	[] ->
	    false;
	[Found | _Rest] ->
	    Found
    end.
%% Alternative version of lookup/2 using recursion.
lookup3(_LastName, []) ->
    false;
lookup3(LastName, [H | _T]) when H#person.lastname =:= LastName ->
    H;
lookup3(LastName, [_H | T]) ->
    lookup3(LastName, T).
