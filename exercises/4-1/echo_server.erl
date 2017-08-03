-module(echo_server) .

-compile(export_all) .
-compile(export_all) .



start() -> register(echo_server,spawn(?MODULE,init,[])) .


print(Term) -> 
echo_server ! {print,Term} , ok. 

terminate() -> 
echo_server ! {terminate, self()} ,
receive	
	{exit} -> io:format("Petla loop zakonczona  ~n", []) 
	end .


init() -> loop().


loop() ->
	receive 
		{print,Data} -> io:format(" ~p  ~n",[Data]) ,
		loop();
		{terminate, Pid} -> 
		Pid ! {exit}
			
	end.
		

