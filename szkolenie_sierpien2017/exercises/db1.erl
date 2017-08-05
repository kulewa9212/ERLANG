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
-spec add(tuple(), list()) -> list().
-spec add(Record, Db1) -> Db2 when Record :: #person{},
				   Db1 = Db2 :: [#person{}].

%% Removes a given record from the list, if found.
-spec del(Record, Db1) -> Db2 when Record :: #person{},
				   Db1 :: [#person{}],
				   Db2 :: [#person{}] | [].

%% Searches the list of records of type #person{} - the key is
%% #person.lastname - and returns the first matching element or
%% atom 'undefined' if no matching occurs.
-spec lookup(LastName, list()) -> Result when LastName :: string() | term(),
					      Result :: #person{} | undefined

%% Alternative version of lookup/2 using list comprehensions.
-spec lookup2(LastName, list()) -> Result when LastName :: string() | term(),
					      Result :: #person{} | undefined

%% Alternative version of lookup/2 using recursion.
-spec lookup3(LastName, list()) -> Result when LastName :: string() | term(),
					      Result :: #person{} | undefined
