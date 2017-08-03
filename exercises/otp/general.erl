-module(general) .
-behavior(gen_server) . 
-compile(export_all) .

-record(person,{name,surname}).

start_link() ->start_link([]) . 

start_link(FileName) -> 
gen_server:start_link({local, ?MODULE}, ?MODULE, FileName, []).


init(People) -> 
{ok,People} . 


add_user(Name,Surname) ->
gen_server:call(?MODULE,{add_user,Name,Surname}).

delete_user(Name,Surname) -> 
gen_server:cast(?MODULE, {delete_user, Name, Surname}) .

how_many() ->
gen_server:call(?MODULE,{how_many}) .

display_users() -> 
gen_server:call(?MODULE,{display_users}) .


display_list([]) -> io:format(" ",[]) ;
display_list([#person{name=Name,surname=Surname}|Tail]) ->
io:format("Name: ~p, ~p ~n", [Name,Surname]),
display_list(Tail) .  



handle_call({add_user,Name,Surname}, From, LoopData) -> 
{reply, #person{name=Name,surname=Surname}, [#person{name=Name,surname=Surname}|LoopData] };
handle_call({how_many} , From, LoopData) ->
{reply, length(LoopData),LoopData} ;
handle_call({display_users} , From, LoopData) -> 
Reply = display_list(LoopData) ,
{reply,Reply,LoopData} .

handle_cast({delete_user,Name,Surname}, LoopData) ->
{noreply, LoopData -- [#person{name=Name,surname=Surname}] } .





loop(People) -> 
receive 
{ok } -> ok
end . 
