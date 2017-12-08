-module(test2).

-compile(export_all).

funkcja2(Arg1,Arg2) ->
io:format("Przed stash: ~w,  ~w ~n", [Arg1,Arg2]).

funkcja_do_usuniecia() -> nie_ok.
