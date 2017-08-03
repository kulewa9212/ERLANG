-module(exceptions).
-export([catchme/1, generate_exception/1]).

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

generate_exception(1) -> a;
generate_exception(2) -> throw(a);
generate_exception(3) -> exit(a);
generate_exception(4) -> erlang:error(a);
generate_exception(5) -> {'EXIT', a}.
