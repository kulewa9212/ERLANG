-module(zadanie3) . 

-compile(export_all) .

create(1) -> [1] ;
create(N) -> create(N-1) ++ [N] . 

print_numbers(1) -> io:format("Number ~p ~n", [1]) ;
print_numbers(N) -> io:format("Number ~p ~n", [N]) ,
			print_numbers(N-1) .

			print_even_numbers(2)  -> io:format("Number ~p ~n", [2]) ;
print_even_numbers(N) when(N rem 2 == 0) -> io:format("Number ~p ~n", [N]) ,
			print_even_numbers(N-2) .
