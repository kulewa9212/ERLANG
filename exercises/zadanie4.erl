-module(zadanie4) .

-compile(export_all) .

init(1) -> [spawn(?MODULE,loop,[])];
init(N) when(is_integer(N)) -> [ spawn(?MODULE,loop,[]) | init(N-1) ] .

loop() -> 
	receive
		{Message, []} -> {exit, ring_cycled} , io:format("ring cycled ~n",[]);
		{Message, [H|T]} -> H ! {Message , T } , io:format("wysylka ~n",[]) 
	end .
		
		

		
<<<<<<< HEAD
send([H|T],M) -> 
	H ! {M, T} ,
=======
send([H|T],Message) -> 
	H ! {Message, T} ,
>>>>>>> 7fb383f... Exercises -> 3 and 4 .
	{ok} .