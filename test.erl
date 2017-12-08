-module(test).

-compile(export_all).


funkcja1(Argument) when is_list(Argument) ->
	io:format("Commit 1 + ~w", [Argument]).