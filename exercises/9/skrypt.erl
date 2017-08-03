-module(skrypt).

-compile(export_all) .

print_list(N) -> 
lists:map(fun(X) -> io:format("~p ~n",[X]) end , lists:seq(1,N)). 

smaller(List, Int) -> [ X || X <- List, X =<Int ] .


sum([]) -> 0;
sum([H|T]) -> H + sum(T) .

three_division(N) when(N>=1) -> [ X || X <- lists:seq(1,N), X>=1, X  rem 3 == 0 ].

squared(List) -> [ X*X || X <- List, is_integer(X) ].

d(List1,List2) -> [ X || X <- List1, lists:member(X,List2) ].

traverse(true) -> false;
traverse(false) -> true. 

skrypt_or(true,true) -> true;
skrypt_or(true,false) -> true;
skrypt_or(false,true) -> true;
skrypt_or(false,false) -> false.


%%intersection() -> [[X || X <- [1,3]] || X <- [1,2] ] .

%%intersection() -> [X || X<-[1,2], skrypt:skrypt_or(X<-[1,3], X<-[1,2]) ] .

zip([],_) -> [];
zip(_,[]) -> [] ;
zip([H1|T1],[H2|T2]) -> [{H1,H2}] ++ zip(T1,T2) .

add(X,Y) -> X+Y .

zipWith(Function,L1,L2) -> Function(L1,L2) . 











