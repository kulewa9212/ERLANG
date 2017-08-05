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

%% Returns reversed string given in Arg
-spec gnirts(Arg) -> string() when Arg :: string().

%% #########################################################
%% BIFs and guards
%% #########################################################

%% Prompts for term from standard input, checks the type
%% and returns a tuple {Type, Value} where Value is the
%% term converted to atom.
-spec convert() -> {Type, atom()} when Type :: atom().

%% #########################################################
%% List comprehensions
%% #########################################################

%% Applies quicksort algorithm on a list of integers in argument.
-spec quicksort(List) -> [integer()] when List :: [integer()].

%% Reverses all elements in the list.
-spec reverse(List1) -> List2 when
      List1 :: [T],
      List2 :: [T],
      T :: term().

%% #########################################################
%% Recursion
%% #########################################################

%% Takes positive integer N and returns the sum of integers between 1 and N
-spec sum(Arg) -> pos_integer() when Arg :: pos_integer().

%% Takes 2 positive integers N and M. If N =< M, returns the sum of interval {N,M}
%% If N > M, the call fails
-spec sum(N, M) -> pos_integer() when N :: pos_integer(),
				      M :: pos_integer().

%% Takes integer N and returns a list [1, 2, 3, ..., N-1, N]
-spec create(N) -> list() when N :: pos_integer().

%% Takes integer N and returns a list [N, N-1, ..., 2, 1]
-spec rev_create(N) -> list() when N :: pos_integer().

%% Takes integer N and prints even integers between 1 and N.
-spec print(N) -> ok when N :: pos_integer().

%% Flattens a list (removes all [] brackets from inside)
-spec flatten(DeepList) -> List when
      DeepList :: [term() | DeepList],
      List :: [term()].

%% Takes a List1 of Elem and returns List2 of Elem*Elem
-spec accumulate(List1) -> List2 when
      Elem1 :: number(),
      Elem2 :: number(),
      List1 :: [Elem1],
      List2 :: [Elem2].

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

%% Calls Fun(A) on every element (A) from List1 and returns
%% List2 consisting of elements (B), where (Fun(A) -> B)
-spec map(Fun, List1) -> List2 when
      Fun :: fun((A) -> B),
      List1 :: [A],
      List2 :: [B],
      A :: term(),
      B :: term().

%% private functions
