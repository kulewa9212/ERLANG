-module(exercises).

-export([even/1,gnirts/1,odwracanie/1]).

even(Arg) when is_integer(Arg)-> 
if
Arg rem 2 =:=0 -> true;
Arg rem 2 =/=0 -> false
end.


odwracanie([]) -> [];
odwracanie(Lista) ->
[lists:last(Lista)] ++ [odwracanie(lists:delete([lists:last(Lista)],Lista))] .


gnirts([]) -> io:format("~n",[]) ;
gnirts(Arg) -> io:format("~c",[lists:last(Arg)]),
gnirts(lists:delete(lists:last(Arg),Arg)) .