%%% @author matt <>
%%% @copyright (C) 2016, matt
%%% @doc
%%%
%%% @end
%%% Created : 10 Dec 2016 by matt <>

-module(preprocessor).
-export([one/0]).

-define(ZERO, 0).
-define(ONE, 1).
-define(PRINT(X), io:format("~p~n", [X])).

-record(whoah,{zero, one, two}).

one() ->
    Record = #whoah{zero = ?ZERO,
		     one = ?ONE,
		     two = 2},
    ?PRINT(Record),
    ok.
