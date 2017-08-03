%%% @author matt <>
%%% @copyright (C) 2016, matt
%%% @doc
%%%
%%% @end
%%% Created :  9 Dec 2016 by matt <>

-module(recursion).
-compile(export_all).

print_interval(X, Y) when X > Y ->
    io:format("done.~n");
print_interval(X, Y) ->
    io:format("~p,",[X]),
    print_interval(X + 1, Y).
