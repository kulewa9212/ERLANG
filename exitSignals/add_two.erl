-module(add_two) .
-export([start/0,request/1,loop/0]) .

start() -> 
	process_flag(trap_exit,true),
	Pid=spawn_link(?MODULE,loop,[]),
	register(add_two,Pid),
	ok.

		
request(Int) -> 
	add_two ! {request, self(), Int},
receive 
	{result, Result} -> Result;
	{'EXIT',_Pid,Reason} -> {error,Reason}
	after 1000 -> timeout
end. 

loop() ->
	receive
		{request, From, Int} -> 
			From ! {result, Int+2}
	end,
loop().