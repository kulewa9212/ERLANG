-module(db).
-export([new/0, destroy/1, write/2, delete/2, read/2, convert/2,key_data/2]).
-record(rcd,{key,data}) .


new() -> [].

write(#rcd{key=Key,data=Data}=R, Db) -> [R|Db].

read(#rcd{key=Key,data=Data}=R, Db) ->
case lists:member(R, Db) of
false -> {error, instance};
true -> {ok, Data}
end.


key_data(Key,[]) -> [] ;
key_data(Key, [#rcd{key=Klucz,data=Data}|T]) -> 
	if Klucz == Key ->
	[Data]++key_data(Key,T) ;
	Klucz /= Key -> key_data(Key,T)
	end .
	





destroy(_Db) -> ok.


delete(Key, Db) -> gb_trees:delete(Key, Db).
convert(dict,Dict) ->
dict(dict:fetch_keys(Dict), Dict, new());
convert(_, Data) ->
Data.

dict([Key|Tail], Dict, GbTree) ->
Data = dict:fetch(Key, Dict),
NewGbTree = gb_trees:insert(Key, Data, GbTree),
dict(Tail, Dict, NewGbTree);
dict([], _, GbTree) -> GbTree.