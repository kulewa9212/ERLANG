-module(skrypt).

-compile(export_all) .

print_list(N) -> 
map(fun(X) -> io:format("~p ~n",[X]) end ., lists:seq(1,N)). 
