%%% @author matt <>
%%% @copyright (C) 2016, matt
%%% @doc
%%%
%%% @end
%%% Created :  4 Dec 2016 by matt <>

-module(exercises).

-export([even/1, gnirts/1, convert/0]).
-export([quicksort/1]).
-export([flatten/1, reverse/1, map/2, mapfilter/3]).
-export([accumulate/1]).
-export([sum/1, sum/2, create/1, rev_create/1, print/1]).

%% #########################################################
%% Modules and functions
%% #########################################################

%% Returns 'true' if Arg is even, 'false' otherwise
-spec even(Arg) -> boolean() when Arg :: integer().
even(Arg) when is_integer(Arg), Arg rem 2 =:= 0 ->
    true;
even(Arg) when is_integer(Arg) ->
    false.

%% Returns reversed string given in Arg
-spec gnirts(Arg) -> string() when Arg :: string().
gnirts(Arg) when is_list(Arg) ->
    reverse(Arg).

%% #########################################################
%% BIFs and guards
%% #########################################################

%% Prompts for term from standard input, checks the type
%% and returns a tuple {Type, Value} where Value is the
%% term converted to atom.
-spec convert() -> {Type, atom()} when Type :: atom().
convert() ->
    {ok, Data} = io:read("Enter a single term:"),
    {Type, Converted} = do_convert(Data),
    %io:format("{~p, ~p}", [Type, Converted]),
    TS = add_and_format_timestamp(),
    {TS, Type, Converted}.

%% #########################################################
%% List comprehensions
%% #########################################################

%% Applies quicksort algorithm on a list of integers in argument.
-spec quicksort(List) -> [integer()] when List :: [integer()].
quicksort([]) -> [];
quicksort([Pivot|T]) ->
		  quicksort([X || X <- T, X < Pivot])
		      ++ [Pivot]
		      ++ quicksort([X || X <- T, X >= Pivot]).

%% Reverses all elements in the list.
-spec reverse(List1) -> List2 when
      List1 :: [T],
      List2 :: [T],
      T :: term().
reverse(List) ->
    reverse(List, []).
reverse([], Acc) -> Acc;
reverse([H|T], Acc) ->
    reverse(T, [H | Acc]).

%% #########################################################
%% Recursion
%% #########################################################

%% Takes positive integer N and returns the sum of integers between 1 and N
-spec sum(Arg) -> pos_integer() when Arg :: pos_integer().
sum(N) when is_integer(N), N > 0 ->
    do_sum(N, 1).

%% Takes 2 positive integers N and M. If N =< M, returns the sum of interval {N,M}
%% If N > M, the call fails
-spec sum(N, M) -> pos_integer() when N :: pos_integer(),
				      M :: pos_integer().
sum(M, N) when is_integer(N), is_integer(M), N > 0, M > 0 ->
    do_sum(M, N, M).

%% Takes integer N and returns a list [1, 2, 3, ..., N-1, N]
-spec create(N) -> list() when N :: pos_integer().
create(N) ->
    do_create(N, []).

%% Takes integer N and returns a list [N, N-1, ..., 2, 1]
-spec rev_create(N) -> list() when N :: pos_integer().
rev_create(N) ->
    reverse(do_create(N, [])).

%% Takes integer N and prints even integers between 1 and N.
-spec print(N) -> ok when N :: pos_integer().
print(N) when is_integer(N), N > 0 ->
    do_print(N, 1).

%% Flattens a list (removes all [] brackets from inside)
-spec flatten(DeepList) -> List when
      DeepList :: [term() | DeepList],
      List :: [term()].
flatten(List) when is_list(List) ->
    do_flatten(List, []).

%% Takes a List1 of Elem and returns List2 of Elem*Elem
-spec accumulate(List1) -> List2 when
      Elem1 :: number(),
      Elem2 :: number(),
      List1 :: [Elem1],
      List2 :: [Elem2].
accumulate(List) ->
    do_accumulate(List, []).

%% #########################################################
%% Funs and higher order functions
%% #########################################################

%% Calls a Fun(Elem) on successive elements Elem of List1,
%% which satisfy a Pred function (Pred must return a Boolean)
%% and returns a list of Values, where each Value is returned
%% from aforementioned Fun(Elem).
%% Pred is a predicate, i.e. fun (X) -> boolean() end
-spec mapfilter(Pred, Fun, List1) -> List2 when
      Elem :: term(),
      Value :: term(),
      Pred :: fun((Elem) -> boolean()),
      Fun :: fun((Elem) -> term()),
      List1 :: [Elem],
      List2 :: [Value].
mapfilter(Pred, Fun, List)
  when is_function(Pred), is_function(Fun), is_list(List) ->
    [Fun(X) || X <- [X || X <- List, Pred(X)]].


%% Calls Fun(A) on every element (A) from List1 and returns
%% List2 consisting of elements (B), where (Fun(A) -> B)
-spec map(Fun, List1) -> List2 when
      Fun :: fun((A) -> B),
      List1 :: [A],
      List2 :: [B],
      A :: term(),
      B :: term().
map(F, [H|T]) ->
    [F(H)|map(F, T)];
map(F, []) when is_function(F, 1) -> [].


%% private functions
do_convert(Data) when is_atom(Data) ->
    {atom, Data};
do_convert(Data) when is_integer(Data) ->
    {integer, list_to_atom(integer_to_list(Data))};
do_convert(Data) when is_float(Data) ->
    {float, list_to_atom(float_to_list(Data))};
do_convert(Data) when is_list(Data) ->
    {list, list_to_atom(Data)};
do_convert(Data) when is_tuple(Data) ->
    {tuple, list_to_atom(tuple_to_list(Data))};
do_convert(_Data) ->
    {error, unsupported_term}.

do_flatten([], Tail) ->
    Tail;
do_flatten([H|T], Tail) when is_list(H), is_list(Tail) ->
    do_flatten(H, do_flatten(T, Tail));
do_flatten([H|T], Tail) ->
    [H|do_flatten(T, Tail)].

do_accumulate([], Acc) ->
    reverse(Acc);
do_accumulate([H|T], Acc) ->
    do_accumulate(T, [H*H | Acc]).

do_sum(1, Acc) -> Acc;
do_sum(N, Acc) ->
    do_sum(N - 1, Acc + N).

do_sum(M, M, Acc) -> Acc;
do_sum(M, N, Acc) when M < N ->
    do_sum(M, N - 1, Acc + N).

do_create(0, Acc) ->
    Acc;
do_create(N, Acc) when is_integer(N), N > 0 ->
    do_create(N-1, [N | Acc]).

do_print(0, _) ->
    done;
do_print(N, Acc) when Acc rem 2 == 0 ->
    io:format("~p ", [Acc]),
    do_print(N - 1, Acc + 1);
do_print(N, Acc) ->
    do_print(N - 1, Acc + 1).

add_and_format_timestamp() ->
    TS = os:timestamp(),
    {{_Year, _Month, _Day}, {Hour, Min, Sec}} =
	 calendar:now_to_local_time(TS),
    PMin = maybe_add_0(Min),
    PSec = maybe_add_0(Sec),
     integer_to_list(Hour) ++
	 ":" ++ PMin ++ "." ++ PSec.

maybe_add_0(Arg) when is_integer(Arg), Arg < 10 ->
    "0" ++ integer_to_list(Arg);
maybe_add_0(Arg) when is_integer(Arg) ->
    integer_to_list(Arg).
