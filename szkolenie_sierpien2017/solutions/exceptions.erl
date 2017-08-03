-module(exceptions).
-export([catchme/1, catchme2/1, catchme3/1, catchme4/1]).
-export([generate_exception/1]).

catchme(N) ->
    try generate_exception(N) of
	    Val ->
		 {N, normal, Val}
	catch
	    throw:X ->
		{N, throw, X};
	    exit:X  ->
		{N, exit, X};
	    error:X ->
		{N, error, X}
	end.

catchme2(N) ->
    catch generate_exception(N).

catchme3(N) ->
	try generate_exception(N) of
	    Val ->
		 {N, normal, Val}
	catch
	    throw:X ->
		{{N, throw, X},
		erlang:get_stacktrace()};
	    exit:X  ->
		{{N, exit, X},
		erlang:get_stacktrace()};
	    error:X ->
		{{N, error, X},
		erlang:get_stacktrace()}
	end.

catchme4(N) ->
	try generate_exception(N) of
	    Val ->
		 {N, normal, Val}
	catch
	    Class:X ->
		polite({N, Class, X}),
		verbose(erlang:get_stacktrace())
	end.

polite(Term) ->
    io:format("~p~n", [Term]).

verbose(Term) ->
    {ok, Device} =
	file:open("exceptions.log", [write, append]),
    io:fwrite(Device, "~p~n", [Term]),
    file:close(Device).

generate_exception(1) -> a;
generate_exception(2) -> throw(a);
generate_exception(3) -> exit(a);
generate_exception(4) -> erlang:error(a);
generate_exception(5) -> {'EXIT', a}.
