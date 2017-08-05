%% Directives (here only 'module' and 'export'):
-module(example).
-export([calc/3, hello/0]).

%% Exported functions:
calc(Arg1, Arg2, sum) ->
    sum(Arg1, Arg2);
calc(Arg1, Arg2, sub) ->
    substr(Arg1, Arg2).
hello() -> io:format("Hello world!~n").

%% Private functions:
sum(Arg1, Arg2) -> Arg1 + Arg2.
substr(Arg1, Arg2) -> sum(Arg1, -Arg2).
